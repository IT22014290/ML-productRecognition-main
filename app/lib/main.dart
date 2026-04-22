import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/camera_screen.dart';
import 'screens/product_list_screen.dart';
import 'services/app_state.dart';
import 'services/detector_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final cameras = await availableCameras();
  runApp(SLProductRecognitionApp(cameras: cameras));
}

class SLProductRecognitionApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const SLProductRecognitionApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..loadScannedItems(),
      child: MaterialApp(
        title: 'SL Product Recognition',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1565C0),
            primary: const Color(0xFF1565C0),
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('si'),
          Locale('ta'),
        ],
        home: MainShell(cameras: cameras),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  final List<CameraDescription> cameras;

  const MainShell({super.key, required this.cameras});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentTab = 0;
  final DetectorService _detector = DetectorService();
  bool _modelLoaded = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      await _detector.load();
      if (mounted) setState(() => _modelLoaded = true);
    } catch (e) {
      if (mounted) setState(() => _loadError = e.toString());
    }
  }

  @override
  void dispose() {
    _detector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.qr_code_scanner, size: 24),
            SizedBox(width: 8),
            Text(
              'SL Product Recognition',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  appState.languageCode.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onSelected: appState.setLanguage,
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'en',
                child: Row(children: [
                  Text('🇬🇧  '),
                  Text('English'),
                ]),
              ),
              PopupMenuItem(
                value: 'si',
                child: Row(children: [
                  Text('🇱🇰  '),
                  Text('සිංහල'),
                ]),
              ),
              PopupMenuItem(
                value: 'ta',
                child: Row(children: [
                  Text('🇱🇰  '),
                  Text('தமிழ்'),
                ]),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _currentTab,
        children: [
          // Tab 0: Camera
          _modelLoaded
              ? CameraScreen(
                  cameras: widget.cameras,
                  detector: _detector,
                )
              : _loadError != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.red, size: 48),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load ML model:\n$_loadError',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() => _loadError = null);
                                _loadModel();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading ML model...'),
                        ],
                      ),
                    ),

          // Tab 1: Scanned list
          const ProductListScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTab,
        onDestinationSelected: (i) => setState(() => _currentTab = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: appState.scannedItems.isNotEmpty,
              label: Text('${appState.scannedItems.length}'),
              child: const Icon(Icons.list_alt_outlined),
            ),
            selectedIcon: const Icon(Icons.list_alt),
            label: 'Scanned List',
          ),
        ],
      ),
    );
  }
}

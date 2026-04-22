import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/app_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final state    = context.watch<AppState>();
    final langCode = state.languageCode;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF1565C0),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.name(langCode),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.inventory_2,
                      size: 72, color: Colors.white24),
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.language, color: Colors.white),
                onSelected: state.setLanguage,
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'en', child: Text('English')),
                  PopupMenuItem(value: 'si', child: Text('සිංහල')),
                  PopupMenuItem(value: 'ta', child: Text('தமிழ்')),
                ],
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _quickInfo(product),
                  const SizedBox(height: 16),
                  _card(
                    icon: Icons.info_outline,
                    title: _l(langCode, 'Description', 'විස්තරය', 'விளக்கம்'),
                    body: product.descriptionText(langCode),
                  ),
                  const SizedBox(height: 12),
                  _card(
                    icon: Icons.science_outlined,
                    title: _l(langCode, 'Ingredients', 'අමුද්‍රව්‍ය', 'பொருட்கள்'),
                    body: product.ingredientText(langCode),
                  ),
                  const SizedBox(height: 12),
                  _card(
                    icon: Icons.warning_amber_outlined,
                    title: _l(langCode, 'Allergens', 'අසාත්මිකතා', 'ஒவ்வாமை'),
                    body: product.allergenText(langCode),
                    titleColor: Colors.orange,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickInfo(Product p) => Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _chip(Icons.store,        p.brand,    Colors.blue),
          _chip(Icons.category,     p.category, Colors.green),
          _chip(Icons.attach_money, p.price,    Colors.purple),
          _chip(Icons.flag,         p.madeIn,   Colors.orange),
          _chip(Icons.scale,        p.weight,   Colors.teal),
        ],
      );

  Widget _chip(IconData icon, String label, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ],
        ),
      );

  Widget _card({
    required IconData icon,
    required String title,
    required String body,
    Color titleColor = const Color(0xFF1565C0),
  }) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: titleColor, size: 20),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ]),
            const SizedBox(height: 10),
            Text(body,
                style: const TextStyle(
                    color: Color(0xFF424242), fontSize: 14, height: 1.5)),
          ],
        ),
      );

  String _l(String lang, String en, String si, String ta) {
    switch (lang) {
      case 'si': return si;
      case 'ta': return ta;
      default:   return en;
    }
  }
}

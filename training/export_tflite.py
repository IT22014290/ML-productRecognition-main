"""
Export trained YOLOv8 weights to TFLite (FP32, FP16 or INT8).

This script converts the best.pt checkpoint produced by train.py into a
TFLite model that can be bundled with the Flutter app.

Defaults to float32 which is guaranteed compatible with tflite_flutter's
CPU delegate on all Android/iOS devices.  Use --float16 for a smaller
binary if your target devices have XNNPACK float16 support.

Usage:
    python export_tflite.py                    # float32 (recommended)
    python export_tflite.py --float16          # float16 (smaller, check compatibility)
    python export_tflite.py --int8             # INT8 quantised (smallest)

Output: product_detection.tflite  (copied automatically to app/assets/models/)
"""

import argparse
import shutil
from pathlib import Path

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('--weights', default='runs/detect/runs/sl_products/weights/best.pt',
                   help='Path to trained best.pt checkpoint')
    p.add_argument('--float16', action='store_true',
                   help='Export float16 weights (smaller but may need GPU delegate for best results)')
    p.add_argument('--int8', action='store_true',
                   help='Enable INT8 quantization (smallest size; may lose ~2-3%% mAP)')
    p.add_argument('--imgsz', type=int, default=640)
    return p.parse_args()


def main():
    args = parse_args()
    weights = Path(args.weights)
    if not weights.exists():
        print(f'[export] ERROR: weights not found at {weights}')
        print('[export] Run train.py first.')
        return

    from ultralytics import YOLO
    model = YOLO(str(weights))

    use_half = args.float16 and not args.int8
    print(f'[export] Exporting {weights} → TFLite  (float16={use_half}, int8={args.int8})')
    export_path = model.export(
        format  = 'tflite',
        imgsz   = args.imgsz,
        half    = use_half,
        int8    = args.int8,
    )

    # Ultralytics names the exported file based on precision:
    #   best_float32.tflite  /  best_float16.tflite  /  best_int8.tflite
    # Pick the correct one so we don't accidentally bundle the wrong variant.
    search_dir = Path(export_path) if Path(export_path).is_dir() else Path(export_path).parent
    if args.int8:
        wanted_suffix = 'int8.tflite'
    elif use_half:
        wanted_suffix = 'float16.tflite'
    else:
        wanted_suffix = 'float32.tflite'

    tflite_file = None
    for f in search_dir.rglob('*.tflite'):
        if f.name.endswith(wanted_suffix):
            tflite_file = f
            break
    if tflite_file is None:          # fallback: take any .tflite
        for f in search_dir.rglob('*.tflite'):
            tflite_file = f
            break

    if tflite_file is None:
        print(f'[export] Could not find .tflite file in {search_dir}')
        return

    dest = Path(__file__).parent.parent / 'app' / 'assets' / 'models' / 'product_detection.tflite'
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(tflite_file, dest)
    print(f'[export] Copied to: {dest}')
    print('[export] Done! Run `flutter run` to test on your Pixel device.')


if __name__ == '__main__':
    main()

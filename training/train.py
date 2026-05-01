"""
YOLOv8 training script for Sri Lankan supermarket product recognition.

Usage:
    pip install -r requirements.txt
    python train.py                  # 320×320 — recommended for mobile (fast inference)
    python train.py --imgsz 640      # 640×640 — higher accuracy, ~4× slower on device
    python train.py --resume         # force-resume from last.pt
    python train.py --fresh          # ignore any existing checkpoint and restart

After training, run:
    python export_tflite.py          # FP32 (safe default)
    python export_tflite.py --int8   # INT8 quantized (~4× faster CPU/NNAPI, ~2% mAP loss)
"""

import argparse
import os
from pathlib import Path
from ultralytics import YOLO

# ── CLI args ───────────────────────────────────────────────────────────────────
def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('--resume', action='store_true',
                   help='Resume from last.pt if available')
    p.add_argument('--fresh',  action='store_true',
                   help='Ignore any existing checkpoint and train from scratch')
    p.add_argument('--imgsz', type=int, default=320,
                   help='Input image size (default: 320 for fast mobile inference; use 640 for higher accuracy)')
    return p.parse_args()

args = parse_args()

# ── Configuration ──────────────────────────────────────────────────────────────
DATA_YAML    = Path(__file__).parent / 'data.yaml'
BASE_MODEL   = 'yolov8n.pt'   # nano: fastest inference on mobile; swap to yolov8s.pt for better accuracy
EPOCHS       = 100
BATCH        = 16
IMAGE_SIZE   = args.imgsz
PROJECT      = 'runs'
RUN_NAME     = 'sl_products'

LAST_PT  = Path(PROJECT) / 'detect' / PROJECT / RUN_NAME / 'weights' / 'last.pt'

# Auto-select device: MPS (Apple Silicon), CUDA (Nvidia GPU), or CPU
import torch
if torch.backends.mps.is_available():
    DEVICE = 'mps'
elif torch.cuda.is_available():
    DEVICE = 0
else:
    DEVICE = 'cpu'

print(f'[train] Using device: {DEVICE}')
print(f'[train] Data config: {DATA_YAML}')

# ── Decide whether to resume ───────────────────────────────────────────────────
if not args.fresh and LAST_PT.exists():
    print(f'[train] Found checkpoint: {LAST_PT}  →  resuming training.')
    model  = YOLO(str(LAST_PT))
    resume = True
else:
    if args.fresh:
        print('[train] --fresh flag set: starting from scratch.')
    print(f'[train] Starting fresh from {BASE_MODEL}')
    model  = YOLO(BASE_MODEL)
    resume = False

# ── Train ──────────────────────────────────────────────────────────────────────
results = model.train(
    data        = str(DATA_YAML),
    epochs      = EPOCHS,
    batch       = BATCH,
    imgsz       = IMAGE_SIZE,
    device      = DEVICE,
    project     = PROJECT,
    name        = RUN_NAME,
    exist_ok    = True,
    resume      = resume,

    # Augmentation
    hsv_h       = 0.015,
    hsv_s       = 0.7,
    hsv_v       = 0.4,
    degrees     = 5.0,
    translate   = 0.1,
    scale       = 0.5,
    flipud      = 0.0,
    fliplr      = 0.5,
    mosaic      = 1.0,
    mixup       = 0.1,
)


print(f'[train] Training complete. Best weights: {results.save_dir}/weights/best.pt')
print('[train] Next: run export_tflite.py to convert to TFLite.')

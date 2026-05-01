"""
Auto-annotate missing label files for link_paspanguwa and kohomba_soup.

Uses color-based segmentation:
  - link_paspanguwa  → yellow-green packet border (high R, high G, low B)
  - kohomba_soup     → dark black box + red banner

Writes YOLO-format .txt files:  <class_id> <cx> <cy> <w> <h>  (normalized 0-1)
"""

import os
import numpy as np
from pathlib import Path
from PIL import Image

DATASET = Path(__file__).parent.parent / 'dataset'

LINK_IMG = DATASET / 'images/train/link_paspanguwa'
LINK_LBL = DATASET / 'labels/train/link_paspanguwa'
LINK_CLASS = 3   # remapped from 18

KOHOMBA_IMG = DATASET / 'images/train/kohomba_soup'
KOHOMBA_LBL = DATASET / 'labels/train/kohomba_soup'
KOHOMBA_CLASS = 2  # remapped from 15

ANCHOR_IMG = DATASET / 'images/train/anchor_milk_powder'
ANCHOR_LBL = DATASET / 'labels/train/anchor_milk_powder'
ANCHOR_CLASS = 0


def bbox_from_mask(mask, h, w, pad=0.05):
    """Convert a binary mask to a padded YOLO bbox (cx, cy, bw, bh)."""
    rows = np.any(mask, axis=1)
    cols = np.any(mask, axis=0)
    if not rows.any() or not cols.any():
        return None
    rmin, rmax = np.where(rows)[0][[0, -1]]
    cmin, cmax = np.where(cols)[0][[0, -1]]
    pad_h = int(h * pad)
    pad_w = int(w * pad)
    rmin = max(0,   rmin - pad_h)
    rmax = min(h-1, rmax + pad_h)
    cmin = max(0,   cmin - pad_w)
    cmax = min(w-1, cmax + pad_w)
    cx = (cmin + cmax) / 2 / w
    cy = (rmin + rmax) / 2 / h
    bw = (cmax - cmin) / w
    bh = (rmax - rmin) / h
    return cx, cy, bw, bh


def annotate_link(img_path):
    """Detect the yellow-green packet and return (cx, cy, bw, bh)."""
    arr = np.array(Image.open(img_path).convert('RGB'))
    h, w = arr.shape[:2]
    r, g, b = arr[:,:,0].astype(int), arr[:,:,1].astype(int), arr[:,:,2].astype(int)

    # Yellow-green: characteristic packet border colour
    mask = (r > 140) & (g > 140) & (b < 90) & ((r - b) > 80)

    result = bbox_from_mask(mask, h, w, pad=0.04)
    if result is None or result[2] < 0.15 or result[3] < 0.15:
        # Fallback: assume product fills most of center
        return 0.50, 0.50, 0.82, 0.82
    return result


def annotate_anchor(img_path):
    """Detect the deep-blue Anchor milk powder box/bag."""
    arr = np.array(Image.open(img_path).convert('RGB'))
    h, w = arr.shape[:2]
    r, g, b = arr[:,:,0].astype(int), arr[:,:,1].astype(int), arr[:,:,2].astype(int)

    # Deep/medium blue: B dominates, G moderate, R low
    blue  = (b > 100) & (b > r + 60) & (b > g + 20) & (r < 140)
    # Red Anchor logo text
    red   = (r > 150) & (g < 80) & (b < 100)

    mask = blue | red

    result = bbox_from_mask(mask, h, w, pad=0.04)
    if result is None or result[2] < 0.15 or result[3] < 0.15:
        return 0.50, 0.50, 0.82, 0.82
    return result


def annotate_kohomba(img_path):
    """Detect the Khomba soap box using its red banner + yellow text."""
    arr = np.array(Image.open(img_path).convert('RGB'))
    h, w = arr.shape[:2]
    r, g, b = arr[:,:,0].astype(int), arr[:,:,1].astype(int), arr[:,:,2].astype(int)

    # Bright red banner (very distinctive, always on the box)
    red    = (r > 170) & (g < 70)  & (b < 70)
    # Yellow "Khomba" text (high R and G, low B)
    yellow = (r > 170) & (g > 130) & (b < 80) & ((r - b) > 100)
    # Green leaf graphics
    green  = (g > 100) & (g > r + 30) & (g > b + 20) & (r < 150)

    mask = red | yellow | green

    result = bbox_from_mask(mask, h, w, pad=0.07)
    if result is None or result[2] < 0.10 or result[3] < 0.10:
        return 0.50, 0.52, 0.75, 0.70
    return result


def write_label(lbl_path, class_id, cx, cy, bw, bh):
    # Clamp to valid range
    bw = min(bw, 1.0)
    bh = min(bh, 1.0)
    cx = max(bw/2, min(1 - bw/2, cx))
    cy = max(bh/2, min(1 - bh/2, cy))
    with open(lbl_path, 'w') as f:
        f.write(f'{class_id} {cx:.6f} {cy:.6f} {bw:.6f} {bh:.6f}\n')


def process_class(img_dir, lbl_dir, class_id, annotate_fn, label, overwrite=False):
    img_dir = Path(img_dir)
    lbl_dir = Path(lbl_dir)
    lbl_dir.mkdir(parents=True, exist_ok=True)

    images = sorted(img_dir.glob('*.jpg'))
    created = 0
    skipped = 0
    for img_path in images:
        lbl_path = lbl_dir / (img_path.stem + '.txt')
        if lbl_path.exists() and not overwrite:
            skipped += 1
            continue
        cx, cy, bw, bh = annotate_fn(img_path)
        write_label(lbl_path, class_id, cx, cy, bw, bh)
        created += 1
        print(f'  [{label}] {img_path.name}  →  {cx:.3f} {cy:.3f} {bw:.3f} {bh:.3f}')

    print(f'\n{label}: wrote {created} labels, skipped {skipped} existing.\n')


if __name__ == '__main__':
    # Force-overwrite anchor_milk_powder — 79/89 were fake generic boxes
    print('=== Re-annotating anchor_milk_powder (class 0) [train] — overwrite ===')
    process_class(ANCHOR_IMG, ANCHOR_LBL, ANCHOR_CLASS, annotate_anchor,
                  'anchor_milk_powder/train', overwrite=True)

    for split in ('train', 'val'):
        print(f'=== Auto-annotating link_paspanguwa [{split}] ===')
        process_class(
            DATASET / f'images/{split}/link_paspanguwa',
            DATASET / f'labels/{split}/link_paspanguwa',
            LINK_CLASS, annotate_link, f'link_paspanguwa/{split}',
        )
        # Overwrite kohomba_soup — red+yellow detection replaces old dark-pixel fallbacks
        print(f'=== Re-annotating kohomba_soup [{split}] — overwrite ===')
        process_class(
            DATASET / f'images/{split}/kohomba_soup',
            DATASET / f'labels/{split}/kohomba_soup',
            KOHOMBA_CLASS, annotate_kohomba, f'kohomba_soup/{split}',
            overwrite=True,
        )

    print('Done. Run: python3 train.py --fresh')

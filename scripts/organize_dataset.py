"""
Dataset organizer: deduplicates, resizes, and splits images into train/val/test.

Run after download_images.py and auto_annotate.py.

Usage:
    python organize_dataset.py
    python organize_dataset.py --min-images 30
    python organize_dataset.py --no-dedup
"""

import argparse
import json
import random
import shutil
from pathlib import Path
from PIL import Image
import imagehash

RAW_DIR    = Path(__file__).parent.parent / 'dataset' / 'images' / 'raw'
IMGS_DIR   = Path(__file__).parent.parent / 'dataset' / 'images'
LABELS_RAW = Path(__file__).parent.parent / 'dataset' / 'labels_raw'
LABELS_DIR = Path(__file__).parent.parent / 'dataset' / 'labels'
DATASET    = Path(__file__).parent.parent / 'dataset'

IMG_EXTS     = {'.jpg', '.jpeg', '.png', '.webp', '.bmp'}
TRAIN_RATIO  = 0.70
VAL_RATIO    = 0.20


def is_valid_image(path: Path) -> bool:
    try:
        with Image.open(path) as img:
            img.verify()
        return True
    except Exception:
        return False


def deduplicate(images: list, threshold: int = 8) -> list:
    unique = []
    seen = []
    for p in images:
        try:
            with Image.open(p) as img:
                h = imagehash.phash(img)
            if not any(abs(h - s) <= threshold for s in seen):
                unique.append(p)
                seen.append(h)
        except Exception:
            pass
    return unique


def resize_and_save(src: Path, dst: Path, size: int = 640):
    dst.parent.mkdir(parents=True, exist_ok=True)
    try:
        with Image.open(src) as img:
            img = img.convert('RGB').resize((size, size), Image.LANCZOS)
            img.save(dst, 'JPEG', quality=90)
    except Exception as e:
        print(f'  [ERROR] resize {src.name}: {e}')


def process_class(class_name: str, images: list, use_dedup: bool) -> dict:
    valid = [p for p in images if is_valid_image(p)]
    print(f'  Valid: {len(valid)}/{len(images)}')

    if use_dedup:
        before = len(valid)
        valid = deduplicate(valid)
        print(f'  After dedup: {len(valid)} (removed {before - len(valid)})')

    random.shuffle(valid)
    n       = len(valid)
    n_train = max(1, int(n * TRAIN_RATIO))
    n_val   = max(1, int(n * VAL_RATIO))

    splits = {
        'train': valid[:n_train],
        'val':   valid[n_train:n_train + n_val],
        'test':  valid[n_train + n_val:],
    }

    counts = {}
    for split, split_imgs in splits.items():
        img_split_dir   = IMGS_DIR / split / class_name
        lbl_split_dir   = LABELS_DIR / split / class_name
        img_split_dir.mkdir(parents=True, exist_ok=True)
        lbl_split_dir.mkdir(parents=True, exist_ok=True)

        for i, src in enumerate(split_imgs):
            stem = f'{class_name}_{split}_{i:04d}'
            dst  = img_split_dir / f'{stem}.jpg'
            resize_and_save(src, dst)
            lbl_src = LABELS_RAW / class_name / (src.stem + '.txt')
            if lbl_src.exists():
                shutil.copy(lbl_src, lbl_split_dir / f'{stem}.txt')
        counts[split] = len(split_imgs)

    return counts


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--min-images', type=int, default=20)
    parser.add_argument('--no-dedup', action='store_true')
    parser.add_argument('--seed', type=int, default=42)
    args = parser.parse_args()

    random.seed(args.seed)
    print('=' * 60)
    print('Dataset Organizer')
    print('=' * 60)

    # Collect classes
    classes = {}
    for class_dir in sorted(RAW_DIR.iterdir()):
        if not class_dir.is_dir():
            continue
        imgs = [p for p in class_dir.iterdir()
                if p.is_file() and p.suffix.lower() in IMG_EXTS]
        if len(imgs) >= args.min_images:
            classes[class_dir.name] = imgs
        else:
            print(f'  Skipping {class_dir.name}: only {len(imgs)} images (need {args.min_images})')

    print(f'\nProcessing {len(classes)} classes...')

    summary = {}
    for class_name, images in sorted(classes.items()):
        print(f'\n[+] {class_name} ({len(images)} images)')
        counts = process_class(class_name, images, use_dedup=not args.no_dedup)
        summary[class_name] = counts
        print(f'  train={counts["train"]} val={counts["val"]} test={counts["test"]}')

    class_names = sorted(summary.keys())
    total_train = sum(v['train'] for v in summary.values())
    total_val   = sum(v['val']   for v in summary.values())
    total_test  = sum(v['test']  for v in summary.values())

    print('\n' + '=' * 60)
    print(f'Classes: {len(class_names)}')
    print(f'Train:   {total_train}')
    print(f'Val:     {total_val}')
    print(f'Test:    {total_test}')
    print('=' * 60)
    print('\nNEXT: cd ../training && python train.py')

    DATASET.mkdir(exist_ok=True)
    (DATASET / 'dataset_summary.json').write_text(
        json.dumps({'classes': class_names, 'nc': len(class_names),
                    'splits': {'train': total_train, 'val': total_val, 'test': total_test},
                    'per_class': summary}, indent=2))


if __name__ == '__main__':
    main()

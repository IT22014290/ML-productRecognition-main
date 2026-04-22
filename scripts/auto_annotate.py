"""
Auto-annotation using Grounding DINO via Hugging Face Transformers.
Generates YOLO-format bounding box labels for downloaded images.

Install:
    pip install transformers torch torchvision pillow tqdm

Usage:
    python auto_annotate.py
    python auto_annotate.py --class-name munchee_marie
    python auto_annotate.py --confidence 0.25
"""

import argparse
import json
from pathlib import Path
from PIL import Image
from tqdm import tqdm

RAW_DIR    = Path(__file__).parent.parent / 'dataset' / 'images' / 'raw'
LABELS_DIR = Path(__file__).parent.parent / 'dataset' / 'labels_raw'
IMG_EXTS   = {'.jpg', '.jpeg', '.png', '.webp'}

# Class index order must match labels.txt and data.yaml
ALL_CLASSES = [
    'anchor_butter', 'anchor_milk_powder', 'astra_margarine', 'baygon_spray',
    'clogard_toothpaste', 'dettol_liquid', 'devonia_coconut_milk', 'dilmah_tea',
    'edna_toffee', 'elephant_house_cream_soda', 'elephant_house_ginger_beer',
    'highland_yogurt', 'indomie_noodles', 'kandos_chocolate', 'knorr_seasoning',
    'larich_chilli_powder', 'lemon_puff', 'lipton_yellow_label', 'maggi_noodles',
    'maliban_ginger', 'maliban_marie', 'md_chilli_sauce', 'md_jam', 'md_tomato_sauce',
    'milco_milk', 'milo_tin', 'munchee_chocolate', 'munchee_cream_cracker',
    'munchee_marie', 'nescafe_3in1', 'nestomalt', 'nip_biscuit',
    'parachute_coconut_oil', 'prima_flour', 'prima_noodles', 'rajah_curry_powder',
    'richlife_milk', 'ritzbury_chocolate', 'samba_rice', 'sunlight_soap',
    'tiara_wafer', 'vim_dishwash', 'wijaya_curry_powder',
]

CLASS_PROMPTS = {
    'anchor_butter':             'anchor butter packet',
    'anchor_milk_powder':        'anchor milk powder tin',
    'astra_margarine':           'astra margarine box',
    'baygon_spray':              'baygon insect spray can',
    'clogard_toothpaste':        'clogard toothpaste tube',
    'dettol_liquid':             'dettol liquid handwash bottle',
    'devonia_coconut_milk':      'devonia coconut milk tin',
    'dilmah_tea':                'dilmah tea box',
    'edna_toffee':               'edna toffee candy packet',
    'elephant_house_cream_soda': 'elephant house cream soda bottle',
    'elephant_house_ginger_beer': 'elephant house ginger beer bottle',
    'highland_yogurt':           'highland yogurt cup',
    'indomie_noodles':           'indomie noodles packet',
    'kandos_chocolate':          'kandos chocolate bar',
    'knorr_seasoning':           'knorr seasoning sachet',
    'larich_chilli_powder':      'larich chilli powder packet',
    'lemon_puff':                'lemon puff biscuit packet',
    'lipton_yellow_label':       'lipton yellow label tea box',
    'maggi_noodles':             'maggi noodles packet',
    'maliban_ginger':            'maliban ginger biscuit packet',
    'maliban_marie':             'maliban marie biscuit packet',
    'md_chilli_sauce':           'md chilli sauce bottle',
    'md_jam':                    'md jam jar',
    'md_tomato_sauce':           'md tomato sauce bottle',
    'milco_milk':                'milco milk carton',
    'milo_tin':                  'milo chocolate tin',
    'munchee_chocolate':         'munchee chocolate biscuit packet',
    'munchee_cream_cracker':     'munchee cream cracker biscuit packet',
    'munchee_marie':             'munchee marie biscuit packet',
    'nescafe_3in1':              'nescafe 3 in 1 coffee sachet',
    'nestomalt':                 'nestomalt tin',
    'nip_biscuit':               'nip biscuit packet',
    'parachute_coconut_oil':     'parachute coconut oil bottle',
    'prima_flour':               'prima flour bag',
    'prima_noodles':             'prima noodles packet',
    'rajah_curry_powder':        'rajah curry powder tin',
    'richlife_milk':             'richlife milk carton',
    'ritzbury_chocolate':        'ritzbury chocolate bar',
    'samba_rice':                'samba rice bag',
    'sunlight_soap':             'sunlight soap bar',
    'tiara_wafer':               'tiara wafer biscuit packet',
    'vim_dishwash':              'vim dishwash powder bar',
    'wijaya_curry_powder':       'wijaya curry powder packet',
}


def load_model():
    from transformers import pipeline as hf_pipeline
    print('Loading Grounding DINO model (~700MB download on first run)...')
    detector = hf_pipeline(
        'zero-shot-object-detection',
        model='IDEA-Research/grounding-dino-tiny',
    )
    print('Model loaded.')
    return detector


def annotate_image(detector, img_path: Path, prompt: str, class_idx: int, confidence: float):
    try:
        image = Image.open(img_path).convert('RGB')
        w, h = image.size
        results = detector(image, candidate_labels=[prompt], threshold=confidence)
        if not results:
            # Fallback: full-image box
            return [f'{class_idx} 0.500000 0.500000 0.900000 0.900000']
        lines = []
        for det in results:
            box = det['box']
            x1, y1, x2, y2 = box['xmin'], box['ymin'], box['xmax'], box['ymax']
            cx = max(0.0, min(1.0, ((x1 + x2) / 2) / w))
            cy = max(0.0, min(1.0, ((y1 + y2) / 2) / h))
            bw = max(0.01, min(1.0, (x2 - x1) / w))
            bh = max(0.01, min(1.0, (y2 - y1) / h))
            lines.append(f'{class_idx} {cx:.6f} {cy:.6f} {bw:.6f} {bh:.6f}')
        return lines
    except Exception as e:
        print(f'  [ERROR] {img_path.name}: {e}')
        return [f'{class_idx} 0.500000 0.500000 0.900000 0.900000']


def run(confidence: float, target_class: str = None):
    detector = load_model()
    LABELS_DIR.mkdir(parents=True, exist_ok=True)

    class_dirs = sorted(RAW_DIR.iterdir()) if not target_class \
        else [RAW_DIR / target_class]

    total = 0
    summary = {}

    for class_dir in class_dirs:
        if not class_dir.is_dir():
            continue
        class_name = class_dir.name
        if class_name not in CLASS_PROMPTS:
            print(f'  Skipping unknown class: {class_name}')
            continue

        prompt    = CLASS_PROMPTS[class_name]
        class_idx = ALL_CLASSES.index(class_name)
        label_dir = LABELS_DIR / class_name
        label_dir.mkdir(parents=True, exist_ok=True)

        images = [p for p in sorted(class_dir.iterdir())
                  if p.suffix.lower() in IMG_EXTS]

        print(f'\n[+] {class_name} ({len(images)} images) — "{prompt}"')

        annotated = 0
        for img_path in tqdm(images, desc=class_name):
            label_path = label_dir / (img_path.stem + '.txt')
            if label_path.exists():
                annotated += 1
                continue
            lines = annotate_image(detector, img_path, prompt, class_idx, confidence)
            label_path.write_text('\n'.join(lines) + '\n')
            annotated += 1

        print(f'  Done: {annotated} labels')
        summary[class_name] = annotated
        total += annotated

    print('\n' + '=' * 60)
    print(f'Total annotated: {total} images')
    print(f'Labels saved to: {LABELS_DIR}')
    (LABELS_DIR / 'annotation_summary.json').write_text(json.dumps(summary, indent=2))
    print('\nNEXT: Run python organize_dataset.py')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--class-name', default=None, help='Annotate one class only')
    parser.add_argument('--confidence', type=float, default=0.25,
                        help='Detection confidence threshold (default: 0.25)')
    args = parser.parse_args()
    print('=' * 60)
    print('Auto-Annotation  —  Grounding DINO (Hugging Face)')
    print(f'Confidence threshold: {args.confidence}')
    print('=' * 60)
    run(args.confidence, args.class_name)


if __name__ == '__main__':
    main()

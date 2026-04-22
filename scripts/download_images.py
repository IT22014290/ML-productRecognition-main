"""
Download product images from DuckDuckGo image search.

Usage:
    pip install -r requirements.txt
    python download_images.py

Images are saved to: ../dataset/images/raw/<class_name>/
"""

import os
import time
import requests
from pathlib import Path
from tqdm import tqdm
from duckduckgo_search import DDGS

# ── Configuration ──────────────────────────────────────────────────────────────
OUTPUT_DIR    = Path(__file__).parent.parent / 'dataset' / 'images' / 'raw'
IMAGES_PER_CLASS = 150
REQUEST_TIMEOUT  = 10

CLASSES = [
    ('anchor_butter',           'Anchor butter Sri Lanka'),
    ('anchor_milk_powder',      'Anchor milk powder Sri Lanka'),
    ('astra_margarine',         'Astra margarine Sri Lanka'),
    ('baygon_spray',            'Baygon insect spray Sri Lanka'),
    ('clogard_toothpaste',      'Clogard toothpaste Sri Lanka'),
    ('dettol_liquid',           'Dettol liquid handwash Sri Lanka'),
    ('devonia_coconut_milk',    'Devonia coconut milk Sri Lanka'),
    ('dilmah_tea',              'Dilmah tea bags Sri Lanka'),
    ('edna_toffee',             'Edna toffee Sri Lanka'),
    ('elephant_house_cream_soda', 'Elephant House cream soda Sri Lanka'),
    ('elephant_house_ginger_beer', 'Elephant House ginger beer Sri Lanka'),
    ('highland_yogurt',         'Highland yogurt Sri Lanka'),
    ('indomie_noodles',         'Indomie noodles packet Sri Lanka'),
    ('kandos_chocolate',        'Kandos chocolate Sri Lanka'),
    ('knorr_seasoning',         'Knorr seasoning Sri Lanka'),
    ('larich_chilli_powder',    'Larich chilli powder Sri Lanka'),
    ('lemon_puff',              'Lemon Puff biscuit Sri Lanka'),
    ('lipton_yellow_label',     'Lipton Yellow Label tea Sri Lanka'),
    ('maggi_noodles',           'Maggi noodles packet Sri Lanka'),
    ('maliban_ginger',          'Maliban ginger biscuit Sri Lanka'),
    ('maliban_marie',           'Maliban marie biscuit Sri Lanka'),
    ('md_chilli_sauce',         'MD chilli sauce bottle Sri Lanka'),
    ('md_jam',                  'MD jam jar Sri Lanka'),
    ('md_tomato_sauce',         'MD tomato sauce bottle Sri Lanka'),
    ('milco_milk',              'Milco milk Sri Lanka'),
    ('milo_tin',                'Milo tin Sri Lanka'),
    ('munchee_chocolate',       'Munchee chocolate biscuit Sri Lanka'),
    ('munchee_cream_cracker',   'Munchee cream cracker Sri Lanka'),
    ('munchee_marie',           'Munchee marie biscuit Sri Lanka'),
    ('nescafe_3in1',            'Nescafe 3in1 sachet Sri Lanka'),
    ('nestomalt',               'Nestomalt tin Sri Lanka'),
    ('nip_biscuit',             'Nip biscuit Sri Lanka'),
    ('parachute_coconut_oil',   'Parachute coconut oil Sri Lanka'),
    ('prima_flour',             'Prima flour bag Sri Lanka'),
    ('prima_noodles',           'Prima noodles packet Sri Lanka'),
    ('rajah_curry_powder',      'Rajah curry powder Sri Lanka'),
    ('richlife_milk',           'Richlife milk carton Sri Lanka'),
    ('ritzbury_chocolate',      'Ritzbury chocolate Sri Lanka'),
    ('samba_rice',              'Samba rice bag Sri Lanka'),
    ('sunlight_soap',           'Sunlight soap bar Sri Lanka'),
    ('tiara_wafer',             'Tiara wafer biscuit Sri Lanka'),
    ('vim_dishwash',            'Vim dishwash powder Sri Lanka'),
    ('wijaya_curry_powder',     'Wijaya curry powder Sri Lanka'),
]


def download_image(url: str, dest: Path) -> bool:
    try:
        r = requests.get(url, timeout=REQUEST_TIMEOUT,
                         headers={'User-Agent': 'Mozilla/5.0'})
        if r.status_code == 200 and len(r.content) > 5000:
            dest.write_bytes(r.content)
            return True
    except Exception:
        pass
    return False


def download_class(class_name: str, query: str):
    out_dir = OUTPUT_DIR / class_name
    out_dir.mkdir(parents=True, exist_ok=True)

    existing = len(list(out_dir.glob('*.jpg'))) + len(list(out_dir.glob('*.png')))
    needed = IMAGES_PER_CLASS - existing
    if needed <= 0:
        print(f'  {class_name}: already have {existing} images, skipping')
        return

    print(f'  {class_name}: downloading {needed} images...')
    count = existing

    try:
        with DDGS() as ddgs:
            results = list(ddgs.images(query, max_results=needed + 30))
        for item in tqdm(results, desc=class_name, leave=False):
            if count >= IMAGES_PER_CLASS:
                break
            url = item.get('image', '')
            if not url:
                continue
            ext = '.jpg'
            if '.png' in url.lower():
                ext = '.png'
            dest = out_dir / f'{class_name}_{count:04d}{ext}'
            if download_image(url, dest):
                count += 1
            time.sleep(0.1)
    except Exception as e:
        print(f'  WARNING: {e}')

    print(f'  {class_name}: {count} images total')


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    print(f'Downloading images to {OUTPUT_DIR}')
    for class_name, query in CLASSES:
        download_class(class_name, query)
    print('Done! Next: run auto_annotate.py then organize_dataset.py')


if __name__ == '__main__':
    main()

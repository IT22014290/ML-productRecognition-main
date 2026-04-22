import '../models/product.dart';

const List<Product> kProducts = [

  // ── BISCUITS ────────────────────────────────────────────────────────────────

  Product(
    id: 'munchee_marie',
    brand: 'Munchee',
    category: 'Biscuits',
    price: 'Rs. 65 – 185',
    madeIn: 'Sri Lanka',
    weight: '170g / 400g',
    names: {
      'en': 'Munchee Marie Biscuit',
      'si': 'මංචී මේරි බිස්කට්',
      'ta': 'முன்சி மேரி பிஸ்கட்',
    },
    description: {
      'en': 'A classic light and crispy biscuit, perfect for tea time. Made by Ceylon Biscuits Ltd.',
      'si': 'තේ වේලාවට සුදුසු සම්භාව්‍ය සැහැල්ලු හා ස්ත‍්‍රි බිස්කට්.',
      'ta': 'டீ நேரத்திற்கு சரியான கிளாசிக் லைட் மற்றும் மிருதுவான பிஸ்கட்.',
    },
    ingredients: {
      'en': 'Wheat flour, sugar, vegetable fat, salt, raising agents (E500, E503), skimmed milk powder.',
      'si': 'තිරිඟු පිටි, සීනි, එළවළු මේදය, ලුණු, ඉහළ නැංවීමේ කාරක (E500, E503), නොමේදු කිරිපිටි.',
      'ta': 'கோதுமை மாவு, சர்க்கரை, காய்கறி கொழுப்பு, உப்பு, உயர்த்தும் முகவர்கள் (E500, E503), கொழுப்பு நீக்கிய பால் தூள்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Milk. May contain traces of Soy, Egg.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), කිරි. සෝයා, බිත්තර අඩංගු විය හැකිය.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), பால். சோயா, முட்டை தடயங்கள் இருக்கலாம்.',
    },
  ),

  Product(
    id: 'munchee_cream_cracker',
    brand: 'Munchee',
    category: 'Biscuits',
    price: 'Rs. 75 – 210',
    madeIn: 'Sri Lanka',
    weight: '190g / 400g',
    names: {
      'en': 'Munchee Cream Cracker',
      'si': 'මංචී ක්‍රීම් ක්‍රැකර්',
      'ta': 'முன்சி கிரீம் கிராக்கர்',
    },
    description: {
      'en': 'A dry, crispy cracker biscuit. Great with butter, cheese, or spreads.',
      'si': 'බටර්, චීස් හෝ ස්ප්‍රෙඩ් සමඟ සිහිල් ක්‍රැකර් බිස්කට්.',
      'ta': 'வெண்ணெய், சீஸ் அல்லது ஸ்பிரெட்டுடன் சிறந்த கிராக்கர் பிஸ்கட்.',
    },
    ingredients: {
      'en': 'Wheat flour, vegetable fat, salt, yeast, raising agents (E503), water.',
      'si': 'තිරිඟු පිටි, එළවළු මේදය, ලුණු, යීස්ට්, ඉහළ නැංවීමේ කාරක (E503), ජලය.',
      'ta': 'கோதுமை மாவு, காய்கறி கொழுப்பு, உப்பு, ஈஸ்ட், உயர்த்தும் முகவர்கள் (E503), தண்ணீர்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten). May contain Milk, Soy.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්). කිරි, සෝයා අඩංගු විය හැකිය.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்). பால், சோயா இருக்கலாம்.',
    },
  ),

  Product(
    id: 'munchee_chocolate',
    brand: 'Munchee',
    category: 'Biscuits',
    price: 'Rs. 70 – 200',
    madeIn: 'Sri Lanka',
    weight: '150g / 400g',
    names: {
      'en': 'Munchee Chocolate Biscuit',
      'si': 'මංචී චොකලට් බිස්කට්',
      'ta': 'முன்சி சாக்லேட் பிஸ்கட்',
    },
    description: {
      'en': 'Chocolate-flavoured biscuits with a rich cocoa taste. A family favourite from Ceylon Biscuits Ltd.',
      'si': 'රත් ස්‍රාවී කොකෝ රසෙන් යුත් චොකලට් බිස්කට්.',
      'ta': 'செழுமையான கோகோ சுவையுடன் சாக்லேட் சுவை பிஸ்கட்.',
    },
    ingredients: {
      'en': 'Wheat flour, sugar, cocoa powder, vegetable fat, salt, raising agents (E500, E503), milk powder.',
      'si': 'තිරිඟු පිටි, සීනි, කොකෝ කුඩු, එළවළු මේදය, ලුණු, ඉහළ නැංවීමේ කාරක, කිරිපිටි.',
      'ta': 'கோதுமை மாவு, சர்க்கரை, கோகோ தூள், காய்கறி கொழுப்பு, உப்பு, உயர்த்தும் முகவர்கள், பால் தூள்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Milk. May contain Soy, Egg.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), කිරි.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), பால்.',
    },
  ),

  Product(
    id: 'maliban_marie',
    brand: 'Maliban',
    category: 'Biscuits',
    price: 'Rs. 60 – 175',
    madeIn: 'Sri Lanka',
    weight: '170g / 400g',
    names: {
      'en': 'Maliban Marie Biscuit',
      'si': 'මලිබන් මේරි බිස්කට්',
      'ta': 'மலிபன் மேரி பிஸ்கட்',
    },
    description: {
      'en': 'A popular Sri Lankan tea-time biscuit with a light, crispy texture.',
      'si': 'ශ්‍රී ලාංකික තේ කාලය සඳහා ජනප්‍රිය සැහැල්ලු, ස්ත‍්‍රි බිස්කට්.',
      'ta': 'லகுவான, மிருதுவான அமைப்புடன் ஒரு பிரபலமான இலங்கை தேநீர் நேர பிஸ்கட்.',
    },
    ingredients: {
      'en': 'Wheat flour, sugar, palm oil, salt, raising agents (E500, E503), milk solids.',
      'si': 'තිරිඟු පිටි, සීනි, පාම් තෙල්, ලුණු, ඉහළ නැංවීමේ කාරක, කිරි ඝනවේගය.',
      'ta': 'கோதுமை மாவு, சர்க்கரை, பாம் எண்ணெய், உப்பு, உயர்த்தும் முகவர்கள், பால் திடப்பொருட்கள்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Milk.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), කිරි.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), பால்.',
    },
  ),

  Product(
    id: 'maliban_ginger',
    brand: 'Maliban',
    category: 'Biscuits',
    price: 'Rs. 65 – 180',
    madeIn: 'Sri Lanka',
    weight: '170g / 400g',
    names: {
      'en': 'Maliban Ginger Biscuit',
      'si': 'මලිබන් ඉඟුරු බිස්කට්',
      'ta': 'மலிபன் இஞ்சி பிஸ்கட்',
    },
    description: {
      'en': 'A spicy ginger-flavoured biscuit. The zingy ginger taste makes it a perfect snack.',
      'si': 'ඉඟුරු රස පූර්ණ බිස්කට්. ශ්‍රී ලාංකික ප්‍රියතම ස්නැක් වර්ගයකි.',
      'ta': 'மசாலா இஞ்சி சுவை கொண்ட பிஸ்கட். சிறந்த சிற்றுண்டியாக விளங்குகிறது.',
    },
    ingredients: {
      'en': 'Wheat flour, sugar, palm oil, ginger powder, salt, raising agents (E500), milk solids.',
      'si': 'තිරිඟු පිටි, සීනි, පාම් තෙල්, ඉඟුරු කුඩු, ලුණු, ඉහළ නැංවීමේ කාරක, කිරි ඝනවේගය.',
      'ta': 'கோதுமை மாவு, சர்க்கரை, பாம் எண்ணெய், இஞ்சி தூள், உப்பு, உயர்த்தும் முகவர்கள், பால் திடப்பொருட்கள்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Milk.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), කිරි.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), பால்.',
    },
  ),

  Product(
    id: 'tiara_wafer',
    brand: 'Tiara',
    category: 'Biscuits',
    price: 'Rs. 50 – 150',
    madeIn: 'Sri Lanka',
    weight: '75g / 150g',
    names: {
      'en': 'Tiara Chocolate Wafer',
      'si': 'ටියාරා චොකලට් වේෆර්',
      'ta': 'டியாரா சாக்லேட் வேஃபர்',
    },
    description: {
      'en': 'Crispy wafer layers filled with smooth chocolate cream. A favourite snack in Sri Lanka.',
      'si': 'සමනල චොකලට් ක්‍රීම් පිරවූ ස්ත‍්‍රි වේෆර් තට්ටු. ශ්‍රී ලංකාවේ ප්‍රියතම ස්නැක්.',
      'ta': 'மிருதுவான சாக்லேட் கிரீம் நிரப்பிய மிருதுவான வேஃபர் அடுக்குகள்.',
    },
    ingredients: {
      'en': 'Wheat flour, sugar, cocoa powder, vegetable fat, milk powder, lecithin (E322), vanilla flavour.',
      'si': 'තිරිඟු පිටි, සීනි, කොකෝ කුඩු, එළවළු මේදය, කිරිපිටි, ලෙසිතින් (E322), වැනිලා ස්වාදය.',
      'ta': 'கோதுமை மாவு, சர்க்கரை, கோகோ தூள், காய்கறி கொழுப்பு, பால் தூள், லெசித்தின் (E322), வெண்ணிலா சுவை.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Milk, Soy (Lecithin).',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), කිරි, සෝයා (ලෙසිතින්).',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), பால், சோயா (லெசித்தின்).',
    },
  ),

  Product(
    id: 'lemon_puff',
    brand: 'Maliban',
    category: 'Biscuits',
    price: 'Rs. 60 – 170',
    madeIn: 'Sri Lanka',
    weight: '150g / 350g',
    names: {
      'en': 'Lemon Puff Biscuit',
      'si': 'ලෙමන් පෆ් බිස්කට්',
      'ta': 'லெமன் பஃப் பிஸ்கட்',
    },
    description: {
      'en': 'A tangy lemon-flavoured cream-filled biscuit sandwich. Very popular in Sri Lanka.',
      'si': 'ලෙමන් රස ක්‍රීම් පිරවූ බිස්කට් සෑන්ඩ්විච්. ශ්‍රී ලංකාවේ ඉතාමත් ජනප්‍රියය.',
      'ta': 'கசப்பான எலுமிச்சை சுவை கிரீம் நிரப்பிய பிஸ்கட் சாண்ட்விச். மிகவும் பிரபலமானது.',
    },
    ingredients: {
      'en': 'Wheat flour, sugar, vegetable fat, lemon flavour, citric acid, salt, raising agents.',
      'si': 'තිරිඟු පිටි, සීනි, එළවළු මේදය, ලෙමන් ස්වාදය, සිට්‍රික් අම්ලය, ලුණු.',
      'ta': 'கோதுமை மாவு, சர்க்கரை, காய்கறி கொழுப்பு, எலுமிச்சை சுவை, சிட்ரிக் அமிலம், உப்பு.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten). May contain Milk.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්). කිරි අඩංගු විය හැකිය.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்). பால் இருக்கலாம்.',
    },
  ),

  Product(
    id: 'nip_biscuit',
    brand: 'Nip',
    category: 'Biscuits',
    price: 'Rs. 55 – 160',
    madeIn: 'Sri Lanka',
    weight: '150g / 350g',
    names: {
      'en': 'Nip Biscuit',
      'si': 'නිප් බිස්කට්',
      'ta': 'நிப் பிஸ்கட்',
    },
    description: {
      'en': 'A crunchy bite-sized biscuit made by Maliban. Perfect as a snack anytime.',
      'si': 'මලිබන් විසින් සාදන ලද කුඩා ස්ත‍්‍රිමත් බිස්කට්. ඕනෑම වේලාවක ස්නැක් ලෙස සුදුසුය.',
      'ta': 'மலிபன் தயாரித்த மிருதுவான சிறிய கடிக்கும் பிஸ்கட்.',
    },
    ingredients: {
      'en': 'Wheat flour, sugar, vegetable fat, salt, raising agents (E503), milk solids.',
      'si': 'තිරිඟු පිටි, සීනි, එළවළු මේදය, ලුණු, ඉහළ නැංවීමේ කාරක (E503), කිරි ඝනවේගය.',
      'ta': 'கோதுமை மாவு, சர்க்கரை, காய்கறி கொழுப்பு, உப்பு, உயர்த்தும் முகவர்கள் (E503), பால் திடப்பொருட்கள்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Milk.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), කිරි.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), பால்.',
    },
  ),

  // ── CHOCOLATES ──────────────────────────────────────────────────────────────

  Product(
    id: 'ritzbury_chocolate',
    brand: 'Ritzbury',
    category: 'Chocolates',
    price: 'Rs. 90 – 250',
    madeIn: 'Sri Lanka',
    weight: '50g / 100g',
    names: {
      'en': 'Ritzbury Chocolate',
      'si': 'රිට්ස්බරි චොකලට්',
      'ta': 'ரிட்ஸ்பரி சாக்லேட்',
    },
    description: {
      'en': 'Premium Sri Lankan chocolate made by Ceylon Biscuits Ltd. Rich and creamy taste.',
      'si': 'Ceylon Biscuits Ltd විසින් නිෂ්පාදිත ශ්‍රේෂ්ඨ ශ්‍රී ලාංකික චොකලට්.',
      'ta': 'Ceylon Biscuits Ltd தயாரித்த பிரீமியம் இலங்கை சாக்லேட்.',
    },
    ingredients: {
      'en': 'Sugar, cocoa butter, cocoa mass, whole milk powder, lecithin (E322), vanilla flavour.',
      'si': 'සීනි, කොකෝ බටර්, කොකෝ ස්කන්ධ, සම්පූර්ණ කිරිපිටි, ලෙසිතින් (E322), වැනිලා ස්වාදය.',
      'ta': 'சர்க்கரை, கோகோ வெண்ணெய், கோகோ திரவம், முழு பால் தூள், லெசித்தின் (E322), வெண்ணிலா சுவை.',
    },
    allergens: {
      'en': 'Contains: Milk, Soy. May contain Nuts.',
      'si': 'අඩංගු වේ: කිරි, සෝයා. ඇට වර්ග අඩංගු විය හැකිය.',
      'ta': 'உள்ளடக்கியது: பால், சோயா. கொட்டைகள் இருக்கலாம்.',
    },
  ),

  Product(
    id: 'kandos_chocolate',
    brand: 'Kandos',
    category: 'Chocolates',
    price: 'Rs. 80 – 300',
    madeIn: 'Sri Lanka',
    weight: '50g / 100g / 200g',
    names: {
      'en': 'Kandos Chocolate',
      'si': 'කැන්ඩොස් චොකලට්',
      'ta': 'கான்டோஸ் சாக்லேட்',
    },
    description: {
      'en': 'One of Sri Lanka\'s most iconic chocolate brands, with a rich smooth flavour.',
      'si': 'ශ්‍රී ලංකාවේ වඩාත්ම ජනප්‍රිය චොකලට් වෙළඳ නාමයකි.',
      'ta': 'இலங்கையின் மிகவும் பிரபலமான சாக்லேட் பிராண்டுகளில் ஒன்று.',
    },
    ingredients: {
      'en': 'Sugar, cocoa butter, cocoa liquor, whole milk powder, emulsifier (E322), vanilla extract.',
      'si': 'සීනි, කොකෝ බටර්, කොකෝ ද්‍රව, සම්පූර්ණ කිරිපිටි, ඉමල්සිෆයර් (E322), වැනිලා සාරය.',
      'ta': 'சர்க்கரை, கோகோ வெண்ணெய், கோகோ திரவம், முழு பால் தூள், குழைவாக்கி (E322), வெண்ணிலா சாறு.',
    },
    allergens: {
      'en': 'Contains: Milk, Soy. May contain Nuts, Peanuts.',
      'si': 'අඩංගු වේ: කිරි, සෝයා. ඇට, රටකජු අඩංගු විය හැකිය.',
      'ta': 'உள்ளடக்கியது: பால், சோயா. கொட்டைகள், வேர்க்கடலை இருக்கலாம்.',
    },
  ),

  Product(
    id: 'edna_toffee',
    brand: 'Edna',
    category: 'Confectionery',
    price: 'Rs. 5 – 50',
    madeIn: 'Sri Lanka',
    weight: '10g / 100g',
    names: {
      'en': 'Edna Toffee',
      'si': 'එඩ්නා ටොෆී',
      'ta': 'எட்னா டோஃபி',
    },
    description: {
      'en': 'A chewy, buttery toffee candy loved by children and adults. Made in Sri Lanka.',
      'si': 'දරුවන් සහ වැඩිහිටියන් ආදරය කරන සරු ටොෆී කැන්ඩි.',
      'ta': 'குழந்தைகள் மற்றும் பெரியவர்கள் விரும்பும் மென்மையான, வெண்ணெய் டோஃபி கேண்டி.',
    },
    ingredients: {
      'en': 'Sugar, glucose syrup, butter, milk, salt, vanilla flavour.',
      'si': 'සීනි, ග්ලූකෝස් සිරප්, බටර්, කිරි, ලුණු, වැනිලා ස්වාදය.',
      'ta': 'சர்க்கரை, குளுக்கோஸ் சிரப், வெண்ணெய், பால், உப்பு, வெண்ணிலா சுவை.',
    },
    allergens: {
      'en': 'Contains: Milk.',
      'si': 'අඩංගු වේ: කිරි.',
      'ta': 'உள்ளடக்கியது: பால்.',
    },
  ),

  // ── DAIRY ────────────────────────────────────────────────────────────────────

  Product(
    id: 'anchor_butter',
    brand: 'Anchor',
    category: 'Dairy',
    price: 'Rs. 350 – 900',
    madeIn: 'New Zealand',
    weight: '250g / 500g',
    names: {
      'en': 'Anchor Butter',
      'si': 'ඇන්කර් බටර්',
      'ta': 'ஆங்கர் வெண்ணெய்',
    },
    description: {
      'en': 'Pure New Zealand butter made from fresh cream. Ideal for cooking, baking, and spreading.',
      'si': 'නිවිතිනි ක්‍රීම් වලින් සාදන ලද පිරිසිදු නවසීලන්ත බටර්.',
      'ta': 'புதிய கிரீம் கொண்டு தயாரிக்கப்பட்ட தூய நியூசிலாந்து வெண்ணெய்.',
    },
    ingredients: {
      'en': 'Cream (from cow\'s milk), salt.',
      'si': 'ක්‍රීම් (ගෝ කිරිවලින්), ලුණු.',
      'ta': 'கிரீம் (பசு பாலிலிருந்து), உப்பு.',
    },
    allergens: {
      'en': 'Contains: Milk.',
      'si': 'අඩංගු වේ: කිරි.',
      'ta': 'உள்ளடக்கியது: பால்.',
    },
  ),

  Product(
    id: 'anchor_milk_powder',
    brand: 'Anchor',
    category: 'Dairy',
    price: 'Rs. 850 – 2,500',
    madeIn: 'New Zealand',
    weight: '400g / 900g / 1.8kg',
    names: {
      'en': 'Anchor Milk Powder',
      'si': 'ඇන්කර් කිරිපිටි',
      'ta': 'ஆங்கர் பால் தூள்',
    },
    description: {
      'en': 'Full cream milk powder from New Zealand. Rich in calcium and essential vitamins.',
      'si': 'නවසීලන්තයේ සම්පූර්ණ ක්‍රීම් කිරිපිටි. කැල්සියම් සහ විටමින් අඩංගු වේ.',
      'ta': 'நியூசிலாந்திலிருந்து முழு கிரீம் பால் தூள். கால்சியம் மற்றும் அத்தியாவசிய வைட்டமின்கள் நிறைந்தது.',
    },
    ingredients: {
      'en': 'Full cream cow\'s milk.',
      'si': 'සම්පූර්ණ ක්‍රීම් ගෝ කිරි.',
      'ta': 'முழு கிரீம் பசு பால்.',
    },
    allergens: {
      'en': 'Contains: Milk.',
      'si': 'අඩංගු වේ: කිරි.',
      'ta': 'உள்ளடக்கியது: பால்.',
    },
  ),

  Product(
    id: 'astra_margarine',
    brand: 'Astra',
    category: 'Dairy',
    price: 'Rs. 250 – 700',
    madeIn: 'Sri Lanka',
    weight: '250g / 500g',
    names: {
      'en': 'Astra Margarine',
      'si': 'ඇස්ට්‍රා මාගරින්',
      'ta': 'ஆஸ்ட்ரா மார்கரின்',
    },
    description: {
      'en': 'A popular vegetable fat-based margarine spread. Great for baking and cooking.',
      'si': 'එළවළු මේද පදනම් මාගරින් ස්ප්‍රෙඩ්. ව්‍යාන්ජනය සහ ෙකේක් සෑදීමට සුදුසුය.',
      'ta': 'பிரபலமான காய்கறி கொழுப்பு அடிப்படையிலான மார்கரின் ஸ்பிரெட்.',
    },
    ingredients: {
      'en': 'Vegetable oils (palm, sunflower), water, salt, emulsifiers (E471, E475), colour (E160a), vitamins A and D.',
      'si': 'එළවළු තෙල් (පාම්, හිරුමල), ජලය, ලුණු, ඉමල්සිෆයර් (E471, E475), වර්ණ (E160a), A සහ D විටමින්.',
      'ta': 'காய்கறி எண்ணெய்கள் (பாம், சூரியகாந்தி), நீர், உப்பு, குழைவாக்கிகள் (E471, E475), நிறம் (E160a), A மற்றும் D வைட்டமின்கள்.',
    },
    allergens: {
      'en': 'May contain Milk. Suitable for vegetarians.',
      'si': 'කිරි අඩංගු විය හැකිය.채채菜식주의자들에게 적합.',
      'ta': 'பால் இருக்கலாம். சைவ உணவு உண்பவர்களுக்கு ஏற்றது.',
    },
  ),

  Product(
    id: 'highland_yogurt',
    brand: 'Highland',
    category: 'Dairy',
    price: 'Rs. 95 – 220',
    madeIn: 'Sri Lanka',
    weight: '100g / 200g',
    names: {
      'en': 'Highland Yogurt',
      'si': 'හයිලන්ඩ් යෝගට්',
      'ta': 'ஹைலேண்ட் தயிர்',
    },
    description: {
      'en': 'Smooth and creamy yogurt available in plain and fruit flavours. Made by Milco (Pvt) Ltd.',
      'si': 'සාමාන්‍ය සහ පළතුරු රසයන් ලෙස ලබා ගත හැකි සිනිදු හා ක්‍රීමී යෝගට්.',
      'ta': 'சாதா மற்றும் பழ சுவைகளில் கிடைக்கும் மிருதுவான மற்றும் கிரீமி தயிர்.',
    },
    ingredients: {
      'en': 'Pasteurised whole milk, live yogurt cultures (Lactobacillus bulgaricus, Streptococcus thermophilus), sugar, fruit preparation.',
      'si': 'පේස්ටරීකරණය කළ සම්පූර්ණ කිරි, යෝගට් සංස්කෘතීන්, සීනි, පළතුරු සූදානම.',
      'ta': 'பாஸ்டுரைஸ் செய்யப்பட்ட முழு பால், தயிர் கலாச்சாரங்கள், சர்க்கரை, பழ தயாரிப்பு.',
    },
    allergens: {
      'en': 'Contains: Milk.',
      'si': 'අඩංගු වේ: කිරි.',
      'ta': 'உள்ளடக்கியது: பால்.',
    },
  ),

  Product(
    id: 'milco_milk',
    brand: 'Milco',
    category: 'Dairy',
    price: 'Rs. 120 – 300',
    madeIn: 'Sri Lanka',
    weight: '200ml / 1L',
    names: {
      'en': 'Milco Full Cream Milk',
      'si': 'මිල්කෝ සම්පූර්ණ ක්‍රීම් කිරි',
      'ta': 'மில்கோ முழு கிரீம் பால்',
    },
    description: {
      'en': 'Fresh pasteurised full cream milk from Sri Lanka. Ideal for drinking and cooking.',
      'si': 'ශ්‍රී ලංකාවේ නැවුම් පේස්ටරීකරණය කළ සම්පූර්ණ ක්‍රීම් කිරි.',
      'ta': 'இலங்கையிலிருந்து புதிய பாஸ்டுரைஸ் செய்யப்பட்ட முழு கிரீம் பால்.',
    },
    ingredients: {
      'en': 'Pasteurised full cream milk.',
      'si': 'පේස්ටරීකරණය කළ සම්පූර්ණ ක්‍රීම් කිරි.',
      'ta': 'பாஸ்டுரைஸ் செய்யப்பட்ட முழு கிரீம் பால்.',
    },
    allergens: {
      'en': 'Contains: Milk.',
      'si': 'අඩංගු වේ: කිරි.',
      'ta': 'உள்ளடக்கியது: பால்.',
    },
  ),

  Product(
    id: 'richlife_milk',
    brand: 'Richlife',
    category: 'Dairy',
    price: 'Rs. 130 – 320',
    madeIn: 'Sri Lanka',
    weight: '200ml / 1L',
    names: {
      'en': 'Richlife Milk',
      'si': 'රිච්ලයිෆ් කිරි',
      'ta': 'ரிட்ச்லைஃப் பால்',
    },
    description: {
      'en': 'UHT processed full cream milk with long shelf life. Convenient for everyday use.',
      'si': 'UHT ක්‍රියාවලිය කළ සම්පූර්ණ ක්‍රීම් කිරි. දිනෙදා භාවිතයට සුදුසු.',
      'ta': 'நீண்ட அலமாரி ஆயுளுடன் UHT செயலாக்கப்பட்ட முழு கிரீம் பால்.',
    },
    ingredients: {
      'en': 'UHT full cream milk, vitamins A and D.',
      'si': 'UHT සම්පූර්ණ ක්‍රීම් කිරි, A සහ D විටමින්.',
      'ta': 'UHT முழு கிரீம் பால், A மற்றும் D வைட்டமின்கள்.',
    },
    allergens: {
      'en': 'Contains: Milk.',
      'si': 'අඩංගු වේ: කිරි.',
      'ta': 'உள்ளடக்கியது: பால்.',
    },
  ),

  // ── BEVERAGES ────────────────────────────────────────────────────────────────

  Product(
    id: 'elephant_house_cream_soda',
    brand: 'Elephant House',
    category: 'Beverages',
    price: 'Rs. 80 – 150',
    madeIn: 'Sri Lanka',
    weight: '400ml / 1.5L',
    names: {
      'en': 'Elephant House Cream Soda',
      'si': 'එලිෆන්ට් හවුස් ක්‍රීම් සෝඩා',
      'ta': 'எலிஃபண்ட் ஹவுஸ் கிரீம் சோடா',
    },
    description: {
      'en': 'Sri Lanka\'s most iconic soft drink. A sweet, creamy-flavoured carbonated beverage loved by all generations.',
      'si': 'ශ්‍රී ලංකාවේ වඩාත්ම ජනප්‍රිය සිසිල් පාන.',
      'ta': 'இலங்கையின் மிகவும் பிரபலமான குளிர்பானம்.',
    },
    ingredients: {
      'en': 'Carbonated water, sugar, citric acid, sodium benzoate (preservative), cream soda flavour, colour (E102, E133).',
      'si': 'කාබනීකෘත ජලය, සීනි, සිට්‍රික් අම්ලය, සෝඩියම් බෙන්සොඅේට්, ක්‍රීම් සෝඩා ස්වාදය, වර්ණය (E102, E133).',
      'ta': 'கார்பனேட்டட் தண்ணீர், சர்க்கரை, சிட்ரிக் அமிலம், சோடியம் பென்சோயேட், கிரீம் சோடா சுவை, நிறம் (E102, E133).',
    },
    allergens: {
      'en': 'No major allergens.',
      'si': 'ප්‍රධාන අසාත්මිකතා නොමැත.',
      'ta': 'முக்கிய ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'elephant_house_ginger_beer',
    brand: 'Elephant House',
    category: 'Beverages',
    price: 'Rs. 85 – 160',
    madeIn: 'Sri Lanka',
    weight: '400ml / 1.5L',
    names: {
      'en': 'Elephant House Ginger Beer',
      'si': 'එලිෆන්ට් හවුස් ජිංජර් බියර්',
      'ta': 'எலிஃபண்ட் ஹவுஸ் ஜிஞ்சர் பீர்',
    },
    description: {
      'en': 'A refreshing non-alcoholic ginger beer with a spicy ginger kick. Made in Sri Lanka.',
      'si': 'ඉඟුරු රසෙන් යුත් නිකොල් ජිංජර් බියර්. ශ්‍රී ලාංකික ප්‍රියතමය.',
      'ta': 'ஒரு புத்துணர்ச்சியூட்டும் ஆல்கஹால் அல்லாத இஞ்சி பீர்.',
    },
    ingredients: {
      'en': 'Carbonated water, sugar, ginger extract, citric acid, preservatives, colour (E150a).',
      'si': 'කාබනීකෘත ජලය, සීනි, ඉඟුරු සාරය, සිට්‍රික් අම්ලය, කල් රකින්නන්, වර්ණ (E150a).',
      'ta': 'கார்பனேட்டட் தண்ணீர், சர்க்கரை, இஞ்சி சாறு, சிட்ரிக் அமிலம், பதப்படுத்திகள், நிறம் (E150a).',
    },
    allergens: {
      'en': 'No major allergens.',
      'si': 'ප්‍රධාන අසාත්මිකතා නොමැත.',
      'ta': 'முக்கிய ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'dilmah_tea',
    brand: 'Dilmah',
    category: 'Beverages',
    price: 'Rs. 350 – 1,200',
    madeIn: 'Sri Lanka',
    weight: '100g / 200g / 400g',
    names: {
      'en': 'Dilmah Ceylon Tea',
      'si': 'ඩිල්මා සිලෝන් තේ',
      'ta': 'டில்மா சிலோன் தேயிலை',
    },
    description: {
      'en': 'Premium single origin Ceylon tea. 100% pure Ceylon tea, ethically sourced and packed in Sri Lanka.',
      'si': 'ශ්‍රේෂ්ඨ තනි ම‌ූලාශ්‍ර සිලෝන් තේ. 100% පිරිසිදු සිලෝන් තේ.',
      'ta': 'பிரீமியம் ஒற்றை மூல சிலோன் தேயிலை. 100% தூய சிலோன் தேயிலை.',
    },
    ingredients: {
      'en': '100% Pure Ceylon tea.',
      'si': '100% පිරිසිදු සිලෝන් තේ.',
      'ta': '100% தூய சிலோன் தேயிலை.',
    },
    allergens: {
      'en': 'No allergens.',
      'si': 'අසාත්මිකතා නැත.',
      'ta': 'ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'lipton_yellow_label',
    brand: 'Lipton',
    category: 'Beverages',
    price: 'Rs. 300 – 1,000',
    madeIn: 'Sri Lanka',
    weight: '100g / 200g / 450g',
    names: {
      'en': 'Lipton Yellow Label Tea',
      'si': 'ලිප්ටන් කහ ලේබල් තේ',
      'ta': 'லிப்டன் மஞ்சள் லேபல் தேயிலை',
    },
    description: {
      'en': 'A blend of the finest Ceylon teas. Bright, refreshing taste for everyday enjoyment.',
      'si': 'ශ්‍රේෂ්ඨ සිලෝන් තේ මිශ්‍රණයකි. දිනෙදා භාවිතයට ගැලපෙන.',
      'ta': 'சிறந்த சிலோன் தேயிலைகளின் கலவை. தினசரி இன்பத்திற்கான பொலிவான, புத்துணர்ச்சியூட்டும் சுவை.',
    },
    ingredients: {
      'en': 'Black tea (100%).',
      'si': 'කළු තේ (100%).',
      'ta': 'கருப்பு தேயிலை (100%).',
    },
    allergens: {
      'en': 'No allergens.',
      'si': 'අසාත්මිකතා නැත.',
      'ta': 'ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'milo_tin',
    brand: 'Nestle',
    category: 'Beverages',
    price: 'Rs. 650 – 1,800',
    madeIn: 'Sri Lanka',
    weight: '200g / 400g / 1kg',
    names: {
      'en': 'Milo Chocolate Malt Drink',
      'si': 'මයිලෝ චොකලට් මොල්ට් බීම',
      'ta': 'மைலோ சாக்லேட் மால்ட் பானம்',
    },
    description: {
      'en': 'A nutritious chocolate and malt drink powder. Rich in iron, calcium and B vitamins.',
      'si': 'පෝෂ්‍යදායී චොකලට් සහ මොල්ට් බීම කුඩු. යකඩ, කැල්සියම් සහ B විටමින් අඩංගු.',
      'ta': 'ஊட்டமளிக்கும் சாக்லேட் மற்றும் மால்ட் பானம் தூள்.',
    },
    ingredients: {
      'en': 'Malt extract, sugar, cocoa powder, milk solids, vitamins and minerals.',
      'si': 'මොල්ට් සාරය, සීනි, කොකෝ කුඩු, කිරි ඝනවේගය, විටමින් සහ ඛනිජ ලවණ.',
      'ta': 'மால்ட் சாறு, சர்க்கரை, கோகோ தூள், பால் திடப்பொருட்கள், வைட்டமின்கள் மற்றும் தாதுக்கள்.',
    },
    allergens: {
      'en': 'Contains: Milk, Gluten (Malt). May contain Soy.',
      'si': 'අඩංගු වේ: කිරි, ග්ලූටන් (මොල්ට්). සෝයා අඩංගු විය හැකිය.',
      'ta': 'உள்ளடக்கியது: பால், குளூட்டன் (மால்ட்). சோயா இருக்கலாம்.',
    },
  ),

  Product(
    id: 'nestomalt',
    brand: 'Nestle',
    category: 'Beverages',
    price: 'Rs. 600 – 1,600',
    madeIn: 'Sri Lanka',
    weight: '200g / 400g',
    names: {
      'en': 'Nestomalt Malt Drink',
      'si': 'නෙස්ටොමොල්ට් මොල්ට් බීම',
      'ta': 'நெஸ்டோமால்ட் மால்ட் பானம்',
    },
    description: {
      'en': 'A nourishing malt-based drink powder fortified with vitamins and minerals. Popular in Sri Lanka.',
      'si': 'විටමින් සහ ඛනිජ ලවණ වලින් ශක්තිමත් කළ පෝෂ්‍යදායී මොල්ට් බීම කුඩු.',
      'ta': 'வைட்டமின்கள் மற்றும் தாதுக்களால் வலுப்படுத்தப்பட்ட மால்ட் அடிப்படையிலான பானம் தூள்.',
    },
    ingredients: {
      'en': 'Malt extract, sugar, milk solids, cocoa, vitamins (A, B1, B2, B6, B12, C, D), minerals (iron, calcium).',
      'si': 'මොල්ට් සාරය, සීනි, කිරි ඝනවේගය, කොකෝ, විටමින්, ඛනිජ ලවණ.',
      'ta': 'மால்ட் சாறு, சர்க்கரை, பால் திடப்பொருட்கள், கோகோ, வைட்டமின்கள், தாதுக்கள்.',
    },
    allergens: {
      'en': 'Contains: Milk, Gluten (Malt).',
      'si': 'අඩංගු වේ: කිරි, ග්ලූටන් (මොල්ට්).',
      'ta': 'உள்ளடக்கியது: பால், குளூட்டன் (மால்ட்).',
    },
  ),

  Product(
    id: 'nescafe_3in1',
    brand: 'Nestle',
    category: 'Beverages',
    price: 'Rs. 30 – 400',
    madeIn: 'Sri Lanka',
    weight: '20g / 200g',
    names: {
      'en': 'Nescafe 3-in-1 Coffee',
      'si': 'නෙස්කෆේ 3-ඉන්-1 කෝපි',
      'ta': 'நெஸ்கஃபே 3-இன்-1 காபி',
    },
    description: {
      'en': 'Instant coffee with coffee, sugar and creamer all in one sachet. Ready in seconds.',
      'si': 'කෝපි, සීනි සහ ක්‍රීමර් එකම ස්ටිකියක. තත්පර කිහිපයකින් සූදානම්.',
      'ta': 'காபி, சர்க்கரை மற்றும் கிரீமர் அனைத்தும் ஒரே சாஷேவில். நொடியில் தயார்.',
    },
    ingredients: {
      'en': 'Sugar, non-dairy creamer (glucose syrup, hydrogenated palm oil, caseinate), instant coffee (8%), salt.',
      'si': 'සීනි, ඩේරි නොවන ක්‍රීමර්, ක්ෂණික කෝපි (8%), ලුණු.',
      'ta': 'சர்க்கரை, பால் அல்லாத கிரீமர், இன்ஸ்டன்ட் காபி (8%), உப்பு.',
    },
    allergens: {
      'en': 'Contains: Milk (Caseinate). May contain Soy.',
      'si': 'අඩංගු වේ: කිරි (කේසිනේට්). සෝයා අඩංගු විය හැකිය.',
      'ta': 'உள்ளடக்கியது: பால் (கேசினேட்). சோயா இருக்கலாம்.',
    },
  ),

  Product(
    id: 'devonia_coconut_milk',
    brand: 'Devonia',
    category: 'Beverages',
    price: 'Rs. 180 – 450',
    madeIn: 'Sri Lanka',
    weight: '400ml',
    names: {
      'en': 'Devonia Coconut Milk',
      'si': 'ඩිවෝනියා පොල් කිරි',
      'ta': 'டெவோனியா தேங்காய் பால்',
    },
    description: {
      'en': 'Pure coconut milk extracted from fresh Sri Lankan coconuts. Ideal for curries and desserts.',
      'si': 'නැවුම් ශ්‍රී ලාංකික පොල් ගෙඩිවලින් නිස්සාරණය කළ පිරිසිදු පොල් කිරි. ව්‍යංජනය සහ රසකැවිලි සඳහා ශ්‍රේෂ්ඨය.',
      'ta': 'புதிய இலங்கை தேங்காய்களில் இருந்து பிரித்தெடுக்கப்பட்ட தூய தேங்காய் பால்.',
    },
    ingredients: {
      'en': 'Coconut milk (95%), water, stabiliser (E412).',
      'si': 'පොල් කිරි (95%), ජලය, ස්ථායීකාරකය (E412).',
      'ta': 'தேங்காய் பால் (95%), நீர், உறுதிப்படுத்தி (E412).',
    },
    allergens: {
      'en': 'Contains: Coconut (tree nut).',
      'si': 'අඩංගු වේ: පොල් (ගස් ගෙඩිය).',
      'ta': 'உள்ளடக்கியது: தேங்காய் (மர கொட்டை).',
    },
  ),

  // ── NOODLES ──────────────────────────────────────────────────────────────────

  Product(
    id: 'prima_noodles',
    brand: 'Prima',
    category: 'Noodles',
    price: 'Rs. 55 – 130',
    madeIn: 'Sri Lanka',
    weight: '80g / 400g',
    names: {
      'en': 'Prima Instant Noodles',
      'si': 'ප්‍රිමා ක්ෂණික නූඩ්ල්ස්',
      'ta': 'பிரிமா இன்ஸ்டன்ட் நூடுல்ஸ்',
    },
    description: {
      'en': 'Sri Lanka\'s favourite instant noodles. Ready in 3 minutes. Available in chicken, vegetable, and fish flavours.',
      'si': 'ශ්‍රී ලංකාවේ ප්‍රියතම ක්ෂණික නූඩ්ල්ස්. මිනිත්තු 3 කින් සූදානම්.',
      'ta': 'இலங்கையின் பிடித்த இன்ஸ்டன்ட் நூடுல்ஸ். 3 நிமிடங்களில் தயார்.',
    },
    ingredients: {
      'en': 'Wheat flour, palm oil, salt, tapioca starch, seasoning (chicken/vegetable/fish flavour, salt, MSG, spices).',
      'si': 'තිරිඟු පිටි, පාම් තෙල්, ලුණු, ටැපිකා පිෂ්ඨය, කළුබඳ.',
      'ta': 'கோதுமை மாவு, பாம் எண்ணெய், உப்பு, டேப்பியோக்கா மாவு, சீஸனிங்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Soy. May contain Crustaceans.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), සෝයා.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), சோயா.',
    },
  ),

  Product(
    id: 'maggi_noodles',
    brand: 'Maggi',
    category: 'Noodles',
    price: 'Rs. 60 – 140',
    madeIn: 'Sri Lanka',
    weight: '80g / 400g',
    names: {
      'en': 'Maggi Instant Noodles',
      'si': 'මැගී ක්ෂණික නූඩ්ල්ස්',
      'ta': 'மேகி இன்ஸ்டன்ட் நூடுல்ஸ்',
    },
    description: {
      'en': 'The world-famous Maggi instant noodles, popular in Sri Lanka. Quick and tasty meal option.',
      'si': 'ලෝ ප්‍රසිද්ධ මැගී ක්ෂණික නූඩ්ල්ස් ශ්‍රී ලංකාවේ ජනප්‍රියයි.',
      'ta': 'உலகப் புகழ்வாய்ந்த மேகி இன்ஸ்டன்ட் நூடுல்ஸ் இலங்கையில் பிரபலமானது.',
    },
    ingredients: {
      'en': 'Wheat flour, palm oil, salt, thickeners (E1422), seasoning mix (salt, sugar, spices, yeast extract, MSG).',
      'si': 'තිරිඟු පිටි, පාම් තෙල්, ලුණු, ඝනකාරක (E1422), කළුබඳ මිශ්‍රණය.',
      'ta': 'கோதுமை மாவு, பாம் எண்ணெய், உப்பு, கெட்டியாக்கிகள் (E1422), சீஸனிங் கலவை.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Soy. May contain Milk, Egg.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), සෝයා.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), சோயா.',
    },
  ),

  Product(
    id: 'indomie_noodles',
    brand: 'Indomie',
    category: 'Noodles',
    price: 'Rs. 70 – 160',
    madeIn: 'Indonesia',
    weight: '80g',
    names: {
      'en': 'Indomie Instant Noodles',
      'si': 'ඉන්ඩොමී ක්ෂණික නූඩ්ල්ස්',
      'ta': 'இண்டோமி இன்ஸ்டன்ட் நூடுல்ஸ்',
    },
    description: {
      'en': 'Indonesia\'s best-selling instant noodles, widely available in Sri Lanka. Comes in Mi Goreng and chicken flavours.',
      'si': 'ශ්‍රී ලංකාවේ ලබා ගත හැකි ඉන්දුනීසියාවේ ශ්‍රේෂ්ඨ ක්ෂණික නූඩ්ල්ස්.',
      'ta': 'இலங்கையில் பரவலாக கிடைக்கும் இந்தோனேசியாவின் சிறந்த விற்பனையாகும் இன்ஸ்டன்ட் நூடுல்ஸ்.',
    },
    ingredients: {
      'en': 'Wheat flour, palm oil, salt, starch, seasoning sauce, chilli powder, garlic powder, onion powder.',
      'si': 'තිරිඟු පිටි, පාම් තෙල්, ලුණු, පිෂ්ඨය, කළුබඳ, මිරිස් කුඩු.',
      'ta': 'கோதுமை மாவு, பாம் எண்ணெய், உப்பு, மாவு, சீஸனிங் சாஸ், மிளகாய் தூள்.',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten), Soy, Egg. May contain Milk, Peanuts.',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්), සෝයා, බිත්තර.',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்), சோயா, முட்டை.',
    },
  ),

  // ── CONDIMENTS & SAUCES ─────────────────────────────────────────────────────

  Product(
    id: 'md_tomato_sauce',
    brand: 'MD',
    category: 'Condiments',
    price: 'Rs. 180 – 550',
    madeIn: 'Sri Lanka',
    weight: '300g / 700g',
    names: {
      'en': 'MD Tomato Sauce',
      'si': 'MD තක්කාලි සෝස්',
      'ta': 'MD தக்காளி சாஸ்',
    },
    description: {
      'en': 'Sri Lanka\'s most popular tomato sauce made from fresh tomatoes. Perfect as a dipping sauce or condiment.',
      'si': 'නැවුම් තක්කාලිවලින් සාදන ලද ශ්‍රී ලංකාවේ ජනප්‍රිය තක්කාලි සෝස්.',
      'ta': 'புதிய தக்காளியால் தயாரிக்கப்பட்ட இலங்கையின் மிகவும் பிரபலமான தக்காளி சாஸ்.',
    },
    ingredients: {
      'en': 'Tomatoes, sugar, vinegar, salt, modified starch, spices, preservatives (E211).',
      'si': 'තක්කාලි, සීනි, විනාකිරි, ලුණු, නවීකරණය කළ පිෂ්ඨය, කුළුබඩු, කල් රකින්නන් (E211).',
      'ta': 'தக்காளி, சர்க்கரை, வினிகர், உப்பு, மாற்றியமைக்கப்பட்ட மாவு, மசாலா, பதப்படுத்திகள் (E211).',
    },
    allergens: {
      'en': 'No major allergens.',
      'si': 'ප්‍රධාන අසාත්මිකතා නොමැත.',
      'ta': 'முக்கிய ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'md_chilli_sauce',
    brand: 'MD',
    category: 'Condiments',
    price: 'Rs. 200 – 600',
    madeIn: 'Sri Lanka',
    weight: '300g / 700g',
    names: {
      'en': 'MD Chilli Sauce',
      'si': 'MD මිරිස් සෝස්',
      'ta': 'MD மிளகாய் சாஸ்',
    },
    description: {
      'en': 'A spicy hot chilli sauce made from Sri Lankan chillies. Great with rice, noodles, and snacks.',
      'si': 'ශ්‍රී ලාංකික මිරිස් වලින් සාදන ලද කරදිය මිරිස් සෝස්. බතල, නූඩ්ල්ස් සහ ස්නැක් සමඟ ශ්‍රේෂ්ඨය.',
      'ta': 'இலங்கை மிளகாய்களால் செய்யப்பட்ட காரமான மிளகாய் சாஸ்.',
    },
    ingredients: {
      'en': 'Chilli peppers, garlic, vinegar, sugar, salt, modified starch, preservatives.',
      'si': 'මිරිස් ගෙඩි, සුදුළුෑනු, විනාකිරි, සීනි, ලුණු, නවීකරණය කළ පිෂ්ඨය, කල් රකින්නන්.',
      'ta': 'மிளகாய் பழங்கள், பூண்டு, வினிகர், சர்க்கரை, உப்பு, மாற்றியமைக்கப்பட்ட மாவு, பதப்படுத்திகள்.',
    },
    allergens: {
      'en': 'No major allergens.',
      'si': 'ප්‍රධාන අසාත්මිකතා නොමැත.',
      'ta': 'முக்கிய ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'md_jam',
    brand: 'MD',
    category: 'Condiments',
    price: 'Rs. 250 – 700',
    madeIn: 'Sri Lanka',
    weight: '330g / 660g',
    names: {
      'en': 'MD Jam',
      'si': 'MD ජෑම්',
      'ta': 'MD ஜாம்',
    },
    description: {
      'en': 'A range of fruit jams made from Sri Lankan tropical fruits. Available in mango, strawberry, and mixed fruit.',
      'si': 'ශ්‍රී ලාංකික නිවර්තන පළතුරු ජෑම් ලෙස ලබා ගත හැකිය. අඹ, ස්ට්‍රෝබෙරි සහ මිශ්‍ර පළතුරු.',
      'ta': 'இலங்கை வெப்பமண்டல பழங்களிலிருந்து தயாரிக்கப்பட்ட பழ ஜாம்கள்.',
    },
    ingredients: {
      'en': 'Fruit (50%), sugar, pectin, citric acid, colour, flavour.',
      'si': 'පළතුරු (50%), සීනි, පෙක්ටින්, සිට්‍රික් අම්ලය, වර්ණ, ස්වාදය.',
      'ta': 'பழம் (50%), சர்க்கரை, பெக்டின், சிட்ரிக் அமிலம், நிறம், சுவை.',
    },
    allergens: {
      'en': 'No major allergens.',
      'si': 'ප්‍රධාන අසාත්මිකතා නොමැත.',
      'ta': 'முக்கிய ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'knorr_seasoning',
    brand: 'Knorr',
    category: 'Condiments',
    price: 'Rs. 80 – 350',
    madeIn: 'Sri Lanka',
    weight: '20g sachet / 100g',
    names: {
      'en': 'Knorr Seasoning Cube',
      'si': 'නෝර් සීසනිං කියූබ්',
      'ta': 'நோர் சீஸனிங் கியூப்',
    },
    description: {
      'en': 'A flavour-enhancing seasoning cube popular in Sri Lankan cooking. Adds depth to curries, soups, and stews.',
      'si': 'ශ්‍රී ලාංකික ව්‍යාන්ජනවල ජනප්‍රිය රස වැඩිකිරීමේ කළුබඳ. ව්‍යංජන, සූප් සහ ස්ටූ රස වැඩි කරයි.',
      'ta': 'இலங்கை சமையலில் பிரபலமான சுவை மேம்படுத்தும் சீஸனிங் கியூப்.',
    },
    ingredients: {
      'en': 'Salt, starch, flavour enhancers (E621, E631), sugar, vegetable fat, spices, yeast extract.',
      'si': 'ලුණු, පිෂ්ඨය, රස වැඩිකාරකයන් (E621, E631), සීනි, එළවළු මේදය, කුළුබඩු, යීස්ට් සාරය.',
      'ta': 'உப்பு, மாவு, சுவை மேம்படுத்திகள் (E621, E631), சர்க்கரை, காய்கறி கொழுப்பு, மசாலா, ஈஸ்ட் சாறு.',
    },
    allergens: {
      'en': 'Contains: Gluten (Wheat), Celery. May contain Milk, Soy.',
      'si': 'අඩංගු වේ: ග්ලූටන් (තිරිඟු), සෙලරි.',
      'ta': 'உள்ளடக்கியது: குளூட்டன் (கோதுமை), செலரி.',
    },
  ),

  // ── SPICES ───────────────────────────────────────────────────────────────────

  Product(
    id: 'wijaya_curry_powder',
    brand: 'Wijaya',
    category: 'Spices',
    price: 'Rs. 120 – 400',
    madeIn: 'Sri Lanka',
    weight: '100g / 200g / 500g',
    names: {
      'en': 'Wijaya Curry Powder',
      'si': 'විජය කරි කුඩු',
      'ta': 'விஜயா கறி பொடி',
    },
    description: {
      'en': 'A blend of authentic Sri Lankan spices for the perfect curry. Made from roasted spices.',
      'si': 'පරිපූර්ණ ව්‍යංජනය සඳහා ඉතාමත් ශ්‍රී ලාංකික කුළුබඩු මිශ්‍රණයකි.',
      'ta': 'சரியான கறிக்கு உண்மையான இலங்கை மசாலாக்களின் கலவை.',
    },
    ingredients: {
      'en': 'Coriander, cumin, chilli, turmeric, fennel, cardamom, cinnamon, cloves, black pepper.',
      'si': 'කොත්තමල්ලි, සුදුරු, මිරිස්, කහ, මහදුරු, ඇල්ම, කුරුඳු, කරාබු නැටි, ගම්මිරිස්.',
      'ta': 'கொத்தமல்லி, சீரகம், மிளகாய், மஞ்சள், பெருஞ்சீரகம், ஏலக்காய், இலவங்கப்பட்டை, கிராம்பு, மிளகு.',
    },
    allergens: {
      'en': 'No allergens. May contain traces of Celery, Mustard.',
      'si': 'අසාත්මිකතා නැත.',
      'ta': 'ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'rajah_curry_powder',
    brand: 'Rajah',
    category: 'Spices',
    price: 'Rs. 150 – 500',
    madeIn: 'UK',
    weight: '100g / 400g',
    names: {
      'en': 'Rajah Curry Powder',
      'si': 'රාජා කරි කුඩු',
      'ta': 'ராஜா கறி பொடி',
    },
    description: {
      'en': 'A popular imported curry powder widely available in Sri Lankan supermarkets. Mild to hot variants.',
      'si': 'ශ්‍රී ලාංකික සුපිරි වෙළඳසැල්වල ජනප්‍රිය ආනයනික කරි කුඩු.',
      'ta': 'இலங்கை சூப்பர் மார்க்கெட்களில் பரவலாக கிடைக்கும் பிரபலமான இறக்குமதி கறி பொடி.',
    },
    ingredients: {
      'en': 'Coriander (40%), cumin, chilli, turmeric, fenugreek, black pepper, salt.',
      'si': 'කොත්තමල්ලි (40%), සුදුරු, මිරිස්, කහ, උළු හාල්, ගම්මිරිස්, ලුණු.',
      'ta': 'கொத்தமல்லி (40%), சீரகம், மிளகாய், மஞ்சள், வெந்தயம், மிளகு, உப்பு.',
    },
    allergens: {
      'en': 'No allergens. May contain Celery, Mustard.',
      'si': 'අසාත්මිකතා නැත.',
      'ta': 'ஒவ்வாமைகள் இல்லை.',
    },
  ),

  Product(
    id: 'larich_chilli_powder',
    brand: 'Larich',
    category: 'Spices',
    price: 'Rs. 100 – 350',
    madeIn: 'Sri Lanka',
    weight: '100g / 250g',
    names: {
      'en': 'Larich Chilli Powder',
      'si': 'ලාරිච් මිරිස් කුඩු',
      'ta': 'லாரிச் மிளகாய் பொடி',
    },
    description: {
      'en': 'Pure ground red chilli powder. Adds authentic heat and colour to Sri Lankan dishes.',
      'si': 'පිරිසිදු රතු මිරිස් කුඩු. ශ්‍රී ලාංකික ව්‍යංජනවලට දළ ගතිය සහ වර්ණය එකතු කරයි.',
      'ta': 'தூய அரைத்த சிவப்பு மிளகாய் தூள். இலங்கை உணவுகளுக்கு உண்மையான காரம் மற்றும் நிறம் சேர்க்கிறது.',
    },
    ingredients: {
      'en': '100% Pure dried red chilli.',
      'si': '100% පිරිසිදු වියළි රතු මිරිස්.',
      'ta': '100% தூய உலர்ந்த சிவப்பு மிளகாய்.',
    },
    allergens: {
      'en': 'No allergens.',
      'si': 'අසාත්මිකතා නැත.',
      'ta': 'ஒவ்வாமைகள் இல்லை.',
    },
  ),

  // ── FLOUR & STAPLES ──────────────────────────────────────────────────────────

  Product(
    id: 'prima_flour',
    brand: 'Prima',
    category: 'Flour & Staples',
    price: 'Rs. 180 – 550',
    madeIn: 'Sri Lanka',
    weight: '1kg / 5kg',
    names: {
      'en': 'Prima Wheat Flour',
      'si': 'ප්‍රිමා තිරිඟු පිටි',
      'ta': 'பிரிமா கோதுமை மாவு',
    },
    description: {
      'en': 'Premium quality wheat flour suitable for baking, cooking, and making Sri Lankan string hoppers and rotis.',
      'si': 'ශ්‍රේෂ්ඨ ගුණාත්මකභාවයේ තිරිඟු පිටි. රොටි, ඉදියාප්ප සහ ව්‍යාන්ජනය සඳහා සුදුසුයි.',
      'ta': 'பேக்கிங், சமையல் மற்றும் இலங்கை ஸ்ட்ரிங் ஹாப்பர்கள் செய்வதற்கு ஏற்ற பிரீமியம் கோதுமை மாவு.',
    },
    ingredients: {
      'en': 'Wheat flour, calcium carbonate, iron, niacin (B3), thiamine (B1).',
      'si': 'තිරිඟු පිටි, කැල්සියම් කාබනේට්, යකඩ, නියාසින් (B3), තියාමයින් (B1).',
      'ta': 'கோதுமை மாவு, கால்சியம் கார்பனேட், இரும்பு, நியாசின் (B3), தியாமின் (B1).',
    },
    allergens: {
      'en': 'Contains: Wheat (Gluten).',
      'si': 'අඩංගු වේ: තිරිඟු (ග්ලූටන්).',
      'ta': 'உள்ளடக்கியது: கோதுமை (குளூட்டன்).',
    },
  ),

  Product(
    id: 'samba_rice',
    brand: 'Various',
    category: 'Flour & Staples',
    price: 'Rs. 200 – 600',
    madeIn: 'Sri Lanka',
    weight: '1kg / 5kg',
    names: {
      'en': 'Samba Rice',
      'si': 'සාම්බා සහල්',
      'ta': 'சம்பா அரிசி',
    },
    description: {
      'en': 'Premium short-grain Sri Lankan Samba rice. A staple grain in Sri Lankan households.',
      'si': 'ශ්‍රේෂ්ඨ කෙටි ධාන්‍ය ශ්‍රී ලාංකික සාම්බා සහල්. ශ්‍රී ලාංකික ගෘහස්ථ ප්‍රධාන ධාන්‍ය.',
      'ta': 'பிரீமியம் குறுமணி இலங்கை சம்பா அரிசி. இலங்கை குடும்பங்களில் முக்கிய தானியம்.',
    },
    ingredients: {
      'en': '100% Samba rice.',
      'si': '100% සාම්බා සහල්.',
      'ta': '100% சம்பா அரிசி.',
    },
    allergens: {
      'en': 'No allergens. Gluten-free.',
      'si': 'අසාත්මිකතා නැත. ග්ලූටන් රහිත.',
      'ta': 'ஒவ்வாமைகள் இல்லை. குளூட்டன் இல்லாதது.',
    },
  ),

  // ── PERSONAL CARE ────────────────────────────────────────────────────────────

  Product(
    id: 'clogard_toothpaste',
    brand: 'Clogard',
    category: 'Personal Care',
    price: 'Rs. 150 – 450',
    madeIn: 'Sri Lanka',
    weight: '75ml / 150ml',
    names: {
      'en': 'Clogard Toothpaste',
      'si': 'ක්ලොගාඩ් දත් පේස්ට්',
      'ta': 'க்ளோகார்ட் பல் விளக்கி',
    },
    description: {
      'en': 'A fluoride toothpaste with Clove oil for strong teeth and gum protection. Made in Sri Lanka.',
      'si': 'ශක්තිමත් දළ හා විෂ ආරක්ෂාව සඳහා කරාබු නැටි තෙල් සහිත ෆ්ලෝරයිඩ් දත් පේස්ට්.',
      'ta': 'வலிமையான பல் மற்றும் ஈறு பாதுகாப்பிற்காக கிராம்பு எண்ணெய் உடன் ஃப்ளோரைடு பல் விளக்கி.',
    },
    ingredients: {
      'en': 'Calcium carbonate, water, sorbitol, silica, sodium lauryl sulfate, fluoride, clove oil, flavour.',
      'si': 'කැල්සියම් කාබනේට්, ජලය, සෝර්බිටෝල්, සිලිකා, සෝඩියම් ලෝරයිල් සල්ෆේට්, ෆ්ලෝරයිඩ්, කරාබු නැටි තෙල්.',
      'ta': 'கால்சியம் கார்பனேட், நீர், சோர்பிடால், சிலிக்கா, சோடியம் லாரில் சல்பேட், ஃப்ளோரைடு, கிராம்பு எண்ணெய்.',
    },
    allergens: {
      'en': 'For external use only (dental). Keep away from children under 6.',
      'si': 'බාහිර භාවිතය (දළ) පමණි. අවු. 6 ට අඩු දරුවන්ගෙන් ඈත් කරන්න.',
      'ta': 'வெளிப்புற பயன்பாட்டிற்கு மட்டுமே (பல்). 6 வயதுக்குட்பட்ட குழந்தைகளிடம் இருந்து விலக்கி வைக்கவும்.',
    },
  ),

  Product(
    id: 'dettol_liquid',
    brand: 'Dettol',
    category: 'Personal Care',
    price: 'Rs. 250 – 750',
    madeIn: 'Sri Lanka',
    weight: '200ml / 500ml',
    names: {
      'en': 'Dettol Liquid Handwash',
      'si': 'ඩෙටෝල් ද්‍රව අත් සෝදන',
      'ta': 'டெட்டால் திரவ கை சோப்பு',
    },
    description: {
      'en': 'Antibacterial liquid handwash. Kills 99.9% of bacteria and germs. Protects the whole family.',
      'si': 'ප්‍රතිබැක්ටීරීය ද්‍රව අත් සෝදන. 99.9% බැක්ටීරියා සහ විෂාණු මරා දමයි.',
      'ta': 'ஆண்டிபாக்டீரியல் திரவ கை சோப்பு. 99.9% பாக்டீரியா மற்றும் கிருமிகளை கொல்கிறது.',
    },
    ingredients: {
      'en': 'Water, sodium laureth sulfate, cocamidopropyl betaine, chloroxylenol (PCMX), fragrance, glycerin, sodium chloride.',
      'si': 'ජලය, සෝඩියම් ලෝරේත් සල්ෆේට්, ක්ලෝරොක්සිලෙනෝල් (PCMX), සුවඳ, ග්ලිසරින්.',
      'ta': 'நீர், சோடியம் லாரெத் சல்பேட், கோகாமிடோபிரோபில் பீட்டைன், குளோரோக்சிலெனால் (PCMX), வாசனை, கிளிசரின்.',
    },
    allergens: {
      'en': 'External use only. Avoid contact with eyes.',
      'si': 'බාහිර භාවිතය පමණි. ඇස් ස්පර්ශ නොකරන්න.',
      'ta': 'வெளிப்புற பயன்பாட்டிற்கு மட்டுமே. கண்களில் படாமல் பார்க்கவும்.',
    },
  ),

  Product(
    id: 'parachute_coconut_oil',
    brand: 'Parachute',
    category: 'Personal Care',
    price: 'Rs. 280 – 850',
    madeIn: 'Sri Lanka',
    weight: '200ml / 500ml',
    names: {
      'en': 'Parachute Coconut Oil',
      'si': 'පැරෂුට් පොල් තෙල්',
      'ta': 'பாராசூட் தேங்காய் எண்ணெய்',
    },
    description: {
      'en': '100% pure coconut oil. Used for hair care, cooking, and skin care. No preservatives added.',
      'si': '100% පිරිසිදු පොල් තෙල්. කෙස් ආරක්ෂාව, ව්‍යාන්ජනය සහ සම ආරක්ෂාව සඳහා.',
      'ta': '100% தூய தேங்காய் எண்ணெய். முடி பராமரிப்பு, சமையல் மற்றும் தோல் பராமரிப்புக்கு.',
    },
    ingredients: {
      'en': '100% Pure coconut oil.',
      'si': '100% පිරිසිදු පොල් තෙල්.',
      'ta': '100% தூய தேங்காய் எண்ணெய்.',
    },
    allergens: {
      'en': 'Contains: Coconut (tree nut).',
      'si': 'අඩංගු වේ: පොල් (ගස් ගෙඩිය).',
      'ta': 'உள்ளடக்கியது: தேங்காய் (மர கொட்டை).',
    },
  ),

  // ── HOUSEHOLD ────────────────────────────────────────────────────────────────

  Product(
    id: 'sunlight_soap',
    brand: 'Sunlight',
    category: 'Household',
    price: 'Rs. 80 – 200',
    madeIn: 'Sri Lanka',
    weight: '95g / 175g',
    names: {
      'en': 'Sunlight Soap Bar',
      'si': 'සන්ලයිට් සබන්',
      'ta': 'சன்லைட் சோப்பு',
    },
    description: {
      'en': 'Multi-purpose laundry and household soap. Known for its effectiveness in cleaning clothes.',
      'si': 'බහු-අරමුණු빨래 සහ ගෘහස්ථ සබන්. ඇඳුම් පිරිසිදු කිරීමේ ඵලදායිතාව සඳහා ප්‍රසිද්ධය.',
      'ta': 'பல்நோக்கு சலவை மற்றும் வீட்டு சோப்பு.',
    },
    ingredients: {
      'en': 'Sodium palmate, sodium palm kernelate, water, glycerin, sodium chloride, fragrance.',
      'si': 'සෝඩියම් පාල්මේට්, සෝඩියම් පාල්ම් කර්නෙලේට්, ජලය, ග්ලිසරින්, ලුණු, සුවඳ.',
      'ta': 'சோடியம் பால்மேட், சோடியம் பாம் கர்னெலேட், தண்ணீர், கிளிசரின், சோடியம் குளோரைடு, வாசனை.',
    },
    allergens: {
      'en': 'For external use only.',
      'si': 'බාහිර භාවිතය පමණි.',
      'ta': 'வெளிப்புற பயன்பாட்டிற்கு மட்டுமே.',
    },
  ),

  Product(
    id: 'vim_dishwash',
    brand: 'Vim',
    category: 'Household',
    price: 'Rs. 100 – 350',
    madeIn: 'Sri Lanka',
    weight: '200g / 500g',
    names: {
      'en': 'Vim Dishwash Bar',
      'si': 'විම් කෑම් භාජන සෝදන',
      'ta': 'விம் டிஷ்வாஷ் பார்',
    },
    description: {
      'en': 'A powerful dishwashing bar that removes grease and tough stains. Widely used in Sri Lankan homes.',
      'si': 'ග්‍රීස් සහ තද කළු ඉවත් කරන ශක්තිමත් භාජන සෝදන. ශ්‍රී ලාංකික ගෙවල්වල බෙහෙවින් භාවිතා වේ.',
      'ta': 'கிரீஸ் மற்றும் கடினமான கறைகளை நீக்கும் சக்திவாய்ந்த பாத்திரம் கழுவும் பார்.',
    },
    ingredients: {
      'en': 'Surfactants, abrasives (calcium carbonate), salt, lemon fragrance, colour.',
      'si': 'Surface-active substances, abrasives (calcium carbonate), ලුණු, ලෙමන් සුවඳ, වර්ණ.',
      'ta': 'சர்ஃபாக்டன்ட்கள், அரிஞ்சிகள் (கால்சியம் கார்பனேட்), உப்பு, எலுமிச்சை வாசனை, நிறம்.',
    },
    allergens: {
      'en': 'For external use only. Avoid contact with eyes.',
      'si': 'බාහිර භාවිතය පමණි.',
      'ta': 'வெளிப்புற பயன்பாட்டிற்கு மட்டுமே.',
    },
  ),

  Product(
    id: 'baygon_spray',
    brand: 'Baygon',
    category: 'Household',
    price: 'Rs. 350 – 900',
    madeIn: 'Sri Lanka',
    weight: '300ml / 600ml',
    names: {
      'en': 'Baygon Insect Spray',
      'si': 'බේගෝන් කෘමිනාශක ස්ප්‍රේ',
      'ta': 'பேகோன் பூச்சி ஸ்ப்ரே',
    },
    description: {
      'en': 'A fast-acting insecticide spray that kills mosquitoes, flies, and cockroaches. Provides long-lasting protection.',
      'si': 'මදුරුවන්, මැස්සන් සහ කූරිස්සන් මරා දමන වේගවත් කෘමිනාශකය. දිගු ස්ථිතිය ආරක්ෂාව සපයයි.',
      'ta': 'கொசுக்கள், ஈக்கள் மற்றும் கரப்பான் பூச்சிகளை கொல்லும் விரைவாக செயல்படும் பூச்சிக்கொல்லி ஸ்ப்ரே.',
    },
    ingredients: {
      'en': 'Propoxur, cyfluthrin, propellants, fragrance. Keep away from food and children.',
      'si': 'ප්‍රොපොක්සර්, සිෆ්ලූත්‍රින්, ලාම්බු, සුවඳ. ආහාර සහ දරුවන්ගෙන් ඈත් කරන්න.',
      'ta': 'ப்ரோபோக்சர், சைஃப்லுத்ரின், உந்துசக்திகள், வாசனை. உணவு மற்றும் குழந்தைகளிடம் இருந்து விலக்கி வைக்கவும்.',
    },
    allergens: {
      'en': 'DANGER: Contains pesticides. Keep away from food, children, and pets. Use in ventilated areas.',
      'si': 'අනතුරු: කෘමිනාශක අඩංගු. ආහාර, දරුවන් සහ සත්ව ගෙවල්වලින් ඈත් කරන්න.',
      'ta': 'ஆபத்து: பூச்சிக்கொல்லிகள் உள்ளடக்கியது. உணவு, குழந்தைகள் மற்றும் செல்லப்பிராணிகளிடம் இருந்து விலக்கி வைக்கவும்.',
    },
  ),
];

/// Lookup product by its class ID (from the ML model's labels.txt).
final Map<String, Product> kProductMap = {
  for (final p in kProducts) p.id: p,
};

Product? findProduct(String id) => kProductMap[id];

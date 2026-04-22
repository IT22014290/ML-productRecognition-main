class Product {
  final String id;
  final Map<String, String> names;
  final String brand;
  final String category;
  final String price;
  final String madeIn;
  final String weight;
  final Map<String, String> ingredients;
  final Map<String, String> description;
  final Map<String, String> allergens;

  const Product({
    required this.id,
    required this.names,
    required this.brand,
    required this.category,
    required this.price,
    required this.madeIn,
    required this.weight,
    required this.ingredients,
    required this.description,
    required this.allergens,
  });

  String name(String langCode) =>
      names[langCode] ?? names['en'] ?? id;

  String ingredientText(String langCode) =>
      ingredients[langCode] ?? ingredients['en'] ?? '';

  String descriptionText(String langCode) =>
      description[langCode] ?? description['en'] ?? '';

  String allergenText(String langCode) =>
      allergens[langCode] ?? allergens['en'] ?? '';
}

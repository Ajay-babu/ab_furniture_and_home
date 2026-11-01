class FurnitureItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final String description;
  final String imageUrl;
  final String material;
  final String dimensions;
  final List<String> availableColors;
  bool isFavorite;
  bool isPopular;

  FurnitureItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.material,
    required this.dimensions,
    required this.availableColors,
    this.isFavorite = false,
    this.isPopular = false,
  });

  FurnitureItem copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    double? rating,
    String? description,
    String? imageUrl,
    String? material,
    String? dimensions,
    List<String>? availableColors,
    bool? isFavorite,
    bool? isPopular,
  }) {
    return FurnitureItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      material: material ?? this.material,
      dimensions: dimensions ?? this.dimensions,
      availableColors: availableColors ?? this.availableColors,
      isFavorite: isFavorite ?? this.isFavorite,
      isPopular: isPopular ?? this.isPopular,
    );
  }
}

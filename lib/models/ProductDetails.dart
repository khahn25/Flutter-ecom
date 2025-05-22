class ProductDetails {
  final String id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String> images;
  final String thumbnail;

  ProductDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
    required this.thumbnail,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class Product {
  final String id;
  final String title;
  final double price;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
  });
}


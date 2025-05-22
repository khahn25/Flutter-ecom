class ProductsModels {
  final int count;
  final String? next;
  final String? previous;
  final List<Results> results;

  ProductsModels({
    required this.count,
    this.next,
    this.previous,
    this.results = const [],
  });

  factory ProductsModels.fromJson(Map<String, dynamic> json) {
    return ProductsModels(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Results.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results.map((e) => e.toJson()).toList(),
      };
}

class Results {
  final String id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final List<dynamic>? colors;
  final List<dynamic>? sizes;
  final List<String>? highlights;
  final double? discountPrice;
  final bool deleted;

  Results({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    this.colors,
    this.sizes,
    this.highlights,
    this.discountPrice,
    this.deleted = false,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      colors: json['colors'] ?? [],
      sizes: json['sizes'] ?? [],
      highlights: (json['highlights'] as List<dynamic>?)?.cast<String>(),
      discountPrice: json['discountPrice'] != null
          ? (json['discountPrice']).toDouble()
          : null,
      deleted: json['deleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images,
        'colors': colors,
        'sizes': sizes,
        'highlights': highlights,
        'discountPrice': discountPrice,
        'deleted': deleted,
      };
}

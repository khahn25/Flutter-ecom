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
  final String name;
  final String slug;
  final List<String> imageUrls;
  final String priceType;
  final String maxPrice;
  final String minPrice;
  final String minDiscountedPrice;

  Results({
    required this.name,
    required this.slug,
    this.imageUrls = const [],
    required this.priceType,
    required this.maxPrice,
    required this.minPrice,
    required this.minDiscountedPrice,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      imageUrls: (json['image_urls'] as List<dynamic>?)?.cast<String>() ?? [],
      priceType: json['price_type'] ?? '',
      maxPrice: json['max_price'] ?? '0',
      minPrice: json['min_price'] ?? '0',
      minDiscountedPrice: json['min_discounted_price'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image_urls': imageUrls,
        'price_type': priceType,
        'max_price': maxPrice,
        'min_price': minPrice,
        'min_discounted_price': minDiscountedPrice,
      };
}

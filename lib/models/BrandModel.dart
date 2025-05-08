class BrandModel {
  final int count;
  final String? next;
  final String? previous;
  final List<Results> results;

  BrandModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>? )
              ?.map((e) => Results.fromJson(e))
              .toList() ?? 
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class Results {
  final String id;  
  final String label;  
  final String value;  
  final String imageUrl;

  Results({
    required this.id,
    required this.label,
    required this.value,
    required this.imageUrl,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['_id'] ?? '',  
      label: json['label'] ?? '',
      value: json['value'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  
      'label': label,
      'value': value,
      'image_url': imageUrl,
    };
  }
}

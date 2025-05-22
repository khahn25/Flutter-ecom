class BrandModel {
  final List<BrandItem> results;

  BrandModel({required this.results});

  factory BrandModel.fromJson(List<dynamic> jsonList) {
    return BrandModel(
      results: jsonList.map((e) => BrandItem.fromJson(e)).toList(),
    );
  }
}

class BrandItem {
  final String id;
  final String label;
  final String value;
  final String imageUrl;

  BrandItem({
    required this.id,
    required this.label,
    required this.value,
    required this.imageUrl,
  });

  factory BrandItem.fromJson(Map<String, dynamic> json) {
    return BrandItem(
      id: json['id'] ?? '',
      label: json['label'] ?? '',
      value: json['value'] ?? '',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
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

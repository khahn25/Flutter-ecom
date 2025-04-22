class ShopModel {
  final bool success;
  final String message;
  final int count;
  final List<ShopData> data;

  ShopModel({
    required this.success,
    required this.message,
    required this.count,
    this.data = const [],
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      count: json['count'] ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ShopData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'count': count,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class ShopData {
  final String slug;
  final String contactNumber;
  final String shopName;
  final String shopImage;
  final int approval;
  final String ownerName;

  ShopData({
    required this.slug,
    required this.contactNumber,
    required this.shopName,
    required this.shopImage,
    required this.approval,
    required this.ownerName,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) {
    return ShopData(
      slug: json['slug'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      shopName: json['shop_name'] ?? '',
      shopImage: json['shop_image'] ?? '',
      approval: json['approval'] ?? 0,
      ownerName: json['owner_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'slug': slug,
        'contact_number': contactNumber,
        'shop_name': shopName,
        'shop_image': shopImage,
        'approval': approval,
        'owner_name': ownerName,
      };
}

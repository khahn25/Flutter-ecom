class ProductDetails {
  final bool success;
  final String message;
  final Data? data;

  ProductDetails({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  final List<Attributes> attributes;
  final List<ProductVariants> productVariants;
  final List<ProductSpecifications> productSpecifications;

  Data({
    this.attributes = const [],
    this.productVariants = const [],
    this.productSpecifications = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => Attributes.fromJson(e))
              .toList() ??
          [],
      productVariants: (json['product_variants'] as List<dynamic>?)
              ?.map((e) => ProductVariants.fromJson(e))
              .toList() ??
          [],
      productSpecifications:
          (json['product_specifications'] as List<dynamic>?)
                  ?.map((e) => ProductSpecifications.fromJson(e))
                  .toList() ??
              [],
    );
  }

  Map<String, dynamic> toJson() => {
        'attributes': attributes.map((e) => e.toJson()).toList(),
        'product_variants': productVariants.map((e) => e.toJson()).toList(),
        'product_specifications':
            productSpecifications.map((e) => e.toJson()).toList(),
      };
}

class Attributes {
  final String attributeSlug;
  final String attributeName;
  final List<AttributeValues> attributeValues;

  Attributes({
    required this.attributeSlug,
    required this.attributeName,
    this.attributeValues = const [],
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      attributeSlug: json['attribute_slug'] ?? '',
      attributeName: json['attribute_name'] ?? '',
      attributeValues: (json['attribute_values'] as List<dynamic>?)
              ?.map((e) => AttributeValues.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'attribute_slug': attributeSlug,
        'attribute_name': attributeName,
        'attribute_values': attributeValues.map((e) => e.toJson()).toList(),
      };
}

class AttributeValues {
  final String value;
  final int key;

  AttributeValues({
    required this.value,
    required this.key,
  });

  factory AttributeValues.fromJson(Map<String, dynamic> json) {
    return AttributeValues(
      value: json['value'] ?? '',
      key: json['key'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'key': key,
      };
}

class ProductVariants {
  final String sku;
  final int variantId;
  final String productName;
  final int approved;
  final dynamic minPrice;
  final dynamic maxPrice;
  final String productDescription;
  final String brandName;
  final String brandSlug;
  final String categorySlug;
  final int categoryId;
  final String categoryName;
  final List<int> attributeValues;
  final List<String> productImages;
  final String colorImage;

  ProductVariants({
    required this.sku,
    required this.variantId,
    required this.productName,
    required this.approved,
    this.minPrice,
    this.maxPrice,
    required this.productDescription,
    required this.brandName,
    required this.brandSlug,
    required this.categorySlug,
    required this.categoryId,
    required this.categoryName,
    this.attributeValues = const [],
    this.productImages = const [],
    required this.colorImage,
  });

  factory ProductVariants.fromJson(Map<String, dynamic> json) {
    return ProductVariants(
      sku: json['sku'] ?? '',
      variantId: json['variant_id'] ?? 0,
      productName: json['product_name'] ?? '',
      approved: json['approved'] ?? 0,
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      productDescription: json['product_description'] ?? '',
      brandName: json['brand_name'] ?? '',
      brandSlug: json['brand_slug'] ?? '',
      categorySlug: json['category_slug'] ?? '',
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'] ?? '',
      attributeValues:
          (json['attribute_values'] as List<dynamic>?)?.cast<int>() ?? [],
      productImages:
          (json['product_images'] as List<dynamic>?)?.cast<String>() ?? [],
      colorImage: json['color_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'sku': sku,
        'variant_id': variantId,
        'product_name': productName,
        'approved': approved,
        'min_price': minPrice,
        'max_price': maxPrice,
        'product_description': productDescription,
        'brand_name': brandName,
        'brand_slug': brandSlug,
        'category_slug': categorySlug,
        'category_id': categoryId,
        'category_name': categoryName,
        'attribute_values': attributeValues,
        'product_images': productImages,
        'color_image': colorImage,
      };
}

class ProductSpecifications {
  final int id;
  final String specificationName;
  final String specificationValue;

  ProductSpecifications({
    required this.id,
    required this.specificationName,
    required this.specificationValue,
  });

  factory ProductSpecifications.fromJson(Map<String, dynamic> json) {
    return ProductSpecifications(
      id: json['id'] ?? 0,
      specificationName: json['specification_name'] ?? '',
      specificationValue: json['specification_value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'specification_name': specificationName,
        'specification_value': specificationValue,
      };
}

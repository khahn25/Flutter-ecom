import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/ProductDetails.dart';
import 'package:food_delivery/utils/Urls.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreen extends StatefulWidget {
  final String slug;

  const ProductDetailScreen({Key? key, required this.slug}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<ProductDetails> productDetailsFuture;

  @override
  void initState() {
    super.initState();
    productDetailsFuture = fetchProductDetails(widget.slug);
  }

  Future<ProductDetails> fetchProductDetails(String slug) async {
    final url = Uri.parse("${Urls.CORE_BASE_URL}$slug");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return ProductDetails.fromJson(body);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chi tiết sản phẩm")),
      body: FutureBuilder<ProductDetails>(
        future: productDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.data == null) {
            return const Center(child: Text("Không có dữ liệu"));
          }

          final data = snapshot.data!.data!;
          final variant = data.productVariants.isNotEmpty ? data.productVariants[0] : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                if (variant != null && variant.productImages.isNotEmpty)
                  Image.network(
                    variant.productImages[0],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                const SizedBox(height: 16),

                // Tên sản phẩm
                Text(
                  variant?.productName ?? "Không rõ tên",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // Giá
                Text(
                  "Giá: ${variant?.minPrice ?? 'N/A'} - ${variant?.maxPrice ?? 'N/A'}",
                  style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                ),

                const SizedBox(height: 16),

                // Mô tả sản phẩm
                Text(
                  variant?.productDescription ?? "Không có mô tả.",
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 16),

                // Thuộc tính
                if (data.attributes.isNotEmpty) ...[
                  const Text("Thuộc tính:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ...data.attributes.map((attr) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${attr.attributeName}:"),
                          Wrap(
                            spacing: 8,
                            children: attr.attributeValues
                                .map((e) => Chip(label: Text(e.value)))
                                .toList(),
                          ),
                        ],
                      )),
                ],

                const SizedBox(height: 16),

                // Thông số kỹ thuật
                if (data.productSpecifications.isNotEmpty) ...[
                  const Text("Thông số kỹ thuật:", style: TextStyle(fontWeight: FontWeight.bold)),
                  ...data.productSpecifications.map((spec) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text("- ${spec.specificationName}: ${spec.specificationValue}"),
                      )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

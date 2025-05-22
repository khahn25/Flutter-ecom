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
      appBar: AppBar(title: const Text("Product Details")),
      body: FutureBuilder<ProductDetails>(
        future: productDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Không có dữ liệu"));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                if (data.images.isNotEmpty)
                  Image.network(
                    data.images[0],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                const SizedBox(height: 16),

                // Tên sản phẩm
                Text(
                  data.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // Giá
                Text(
                  "Price: \$${data.price.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                ),

                const SizedBox(height: 8),

                // Đánh giá
                Text("Rate: ${data.rating} ⭐"),

                const SizedBox(height: 16),

                // Mô tả sản phẩm
                Text(
                  data.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

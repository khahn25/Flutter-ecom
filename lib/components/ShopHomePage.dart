import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/CircularProgress.dart';
import 'package:food_delivery/common_widget/GridTilesCategory.dart';
import 'package:food_delivery/models/ShopModel.dart';
import 'package:http/http.dart' as http;

class ShopHomePage extends StatefulWidget {
  final String slug;
  final bool isSubList;

  const ShopHomePage({Key? key, required this.slug, this.isSubList = false}) : super(key: key);

  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  List<ShopModel> productList = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final url = 'https://api.escuelajs.co/api/v1/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        log('Product API Response: $body');

        setState(() {
          productList = body.map((item) => ShopModel.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return CircularProgress();

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchProducts,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (productList.isEmpty) {
      return const Center(child: Text('No products found.'));
    }

    return RefreshIndicator(
      onRefresh: _fetchProducts,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 8.0 / 10.0,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final item = productList[index];
          return GridTilesCategory(
            name: item.title ?? 'No Title',
            imageUrl: (item.images?.isNotEmpty ?? false) ? item.images!.first : '',
            slug: item.slug ?? '',
          );
        },
      ),
    );
  }
}

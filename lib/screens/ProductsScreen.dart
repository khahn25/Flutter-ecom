import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/AppBarWidget.dart';
import 'package:food_delivery/common_widget/CircularProgress.dart';
import 'package:food_delivery/common_widget/GridTilesProducts.dart';
import 'package:food_delivery/models/ProductsModel.dart';
import 'package:food_delivery/utils/Urls.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  final String name;
  final String slug;

  const ProductsScreen({Key? key, required this.name, required this.slug})
      : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ProductListWidget(slug: widget.slug),
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  final String slug;

  const ProductListWidget({Key? key, required this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductsModels>(
      future: getProductList(slug, false),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgress();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return const Center(child: Text('No products found.'));
        }
        return createListView(context, snapshot.data!);
      },
    );
  }
}

ProductsModels? products;

Future<ProductsModels> getProductList(String slug, bool isSubList) async {
  if (isSubList) {
    products = null;
  }
  if (products == null) {
    try {
      final response = await http.get(Uri.parse(Urls.CORE_BASE_URL + slug));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        products = ProductsModels.fromJson(body);
        return products!;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  } else {
    return products!;
  }
}

Widget createListView(BuildContext context, ProductsModels values) {
  if (values.results.isEmpty) {
    return const Center(child: Text('No products available'));
  }

  return GridView.builder(
    padding: const EdgeInsets.all(1.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 8.0 / 12.0,
    ),
    itemCount: values.results.length,
    itemBuilder: (context, index) {
      final product = values.results[index];
      return GridTile(
        child: GridTilesProducts(
          name: product.title,
          imageUrl: product.thumbnail,
          slug: product.id, // hoặc route bạn cần
          price: product.discountPrice?.toString() ?? product.price.toString(),

        ),
      );
    },
  );
}

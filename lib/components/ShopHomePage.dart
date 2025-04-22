import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/CircularProgress.dart';
import 'package:food_delivery/common_widget/GridTilesCategory.dart';
import 'package:food_delivery/models/ShopModel.dart';
import 'package:food_delivery/utils/Urls.dart';
import 'package:http/http.dart' as http;

class ShopHomePage extends StatefulWidget {
  final String slug;
  final bool isSubList;

  const ShopHomePage({Key? key, required this.slug, this.isSubList = false}) : super(key: key);

  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  ShopModel? shopModel;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchShops();
  }

  Future<void> _fetchShops() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse(Urls.CORE_BASE_URL + widget.slug));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        log(body.toString());
        setState(() {
          shopModel = ShopModel.fromJson(body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load shops');
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
    if (isLoading) {
      return  CircularProgress();
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchShops,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (shopModel == null || shopModel!.data.isEmpty) {
      return const Center(child: Text('No shops found.'));
    }

    return RefreshIndicator(
      onRefresh: _fetchShops,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 8.0 / 9.0,
        ),
        itemCount: shopModel!.data.length,
        itemBuilder: (context, index) {
          final item = shopModel!.data[index];
          return GridTilesCategory(
            name: item.shopName,
            imageUrl: item.shopImage,
            slug: item.slug,
          );
        },
      ),
    );
  }
}

//https://api.evaly.com.bd/core/public/category/shops/bags-luggage-966bc8aac/?page=1&limit=15
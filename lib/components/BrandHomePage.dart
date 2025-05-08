import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/CircularProgress.dart';
import 'package:food_delivery/common_widget/GridTilesCategory.dart';
import 'package:http/http.dart' as http;
import '../models/BrandModel.dart';

class BrandHomePage extends StatefulWidget {
  final String slug;
  final bool isSubList;

  const BrandHomePage({Key? key, required this.slug, this.isSubList = false}) : super(key: key);

  @override
  _BrandHomePageState createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<BrandHomePage> {
  BrandModel? brandModel;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCategoryList();
  }

  Future<void> _fetchCategoryList() async {
    try {
      // Sử dụng URL cố định
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/brands'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        log(body.toString());
        setState(() {
          brandModel = BrandModel.fromJson(body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load brands');
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
      return CircularProgress();
    }
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }
    if (brandModel == null || brandModel!.results.isEmpty) {
      return const Center(child: Text('No brands found.'));
    }
    return createListView(brandModel!);
  }

  Widget createListView(BrandModel brandData) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 8.0 / 9.0,
      ),
      itemCount: brandData.results.length,
      itemBuilder: (context, index) {
        final item = brandData.results[index];
        return GridTilesCategory(
          name: item.label,
          imageUrl: item.imageUrl,
          slug: item.value,
        );
      },
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/CategoryModel.dart';
import 'package:food_delivery/common_widget/CircularProgress.dart';
import 'package:food_delivery/common_widget/GridTilesCategory.dart';
import 'package:food_delivery/utils/Urls.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  final String slug;
  final bool isSubList;

  const CategoryPage({Key? key, required this.slug, this.isSubList = false}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryModel> categories = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCategoryList();
  }

  Future<void> _fetchCategoryList() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse(Urls.CORE_BASE_URL + widget.slug));

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);

        setState(() {
          categories = body.map((item) => CategoryModel.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchCategoryList,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (categories.isEmpty) {
      return const Center(child: Text('No categories found.'));
    }

    return RefreshIndicator(
      onRefresh: _fetchCategoryList,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 8.0 / 9.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];

          return GridTilesCategory(
            name: item.name ?? 'No Name',
            imageUrl: item.image ?? '', 
            slug: item.slug ?? '',       
            fromSubProducts: widget.isSubList,
          );
        },
      ),
    );
  }
}

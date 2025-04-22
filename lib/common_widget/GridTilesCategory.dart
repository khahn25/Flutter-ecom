import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/screens/ProductsScreen.dart';
import 'package:food_delivery/screens/SubCategoryScreen.dart';

class GridTilesCategory extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String slug;
  final bool fromSubProducts;

  const GridTilesCategory({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.slug,
    this.fromSubProducts = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (fromSubProducts) {
          log(slug);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                slug: "products/?page=1&limit=12&category=$slug",
                name: name,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubCategoryScreen(slug: slug),
            ),
          );
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                imageUrl,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

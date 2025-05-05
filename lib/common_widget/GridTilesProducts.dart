import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/screens/ProductDetailScreen.dart';

class GridTilesProducts extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String slug;
  final String? price;

  const GridTilesProducts({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.slug,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log("Navigating to: $slug");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(slug: "products/$slug/"),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          elevation: 0,
          child: Center(
            child: Column(
              children: <Widget>[
                Image.network(
                  imageUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(
                    name.length <= 40 ? name : "${name.substring(0, 40)}...",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFF444444),
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    price != null ? "VND $price" : "Unavailable",
                    style: TextStyle(
                      color: price != null ? const Color(0xFFf67426) : const Color(0xFF0dc2cd),
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

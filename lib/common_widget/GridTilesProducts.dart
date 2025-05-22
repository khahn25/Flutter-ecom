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
        final fullSlug = "/products/$slug/";
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(slug: fullSlug),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        margin: const EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                name.length <= 40 ? name : "${name.substring(0, 40)}...",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                price != null ? " $price" : "Unavailable",
                style: TextStyle(
                  color: price != null ? const Color(0xFFf67426) : Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

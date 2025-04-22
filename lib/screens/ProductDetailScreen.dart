import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_delivery/common_widget/AppBarWidget.dart';
import 'package:food_delivery/common_widget/CircularProgress.dart';
import 'package:food_delivery/models/ProductDetails.dart';
import 'package:food_delivery/utils/Urls.dart';

class ProductDetailScreen extends StatefulWidget {
  final String slug;

  const ProductDetailScreen({Key? key, required this.slug}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<ProductDetails> futureProductDetails;

  @override
  void initState() {
    super.initState();
    futureProductDetails = getDetailData(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfafafa),
      appBar: appBarWidget(context),
      body: FutureBuilder<ProductDetails>(
        future: futureProductDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgress();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }
          return DetailScreen(productDetails: snapshot.data!);
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          const Icon(Icons.favorite_border, color: Color(0xFF5e5e5e)),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFfef2f2),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                side: BorderSide(color: Color(0xFFfef2f2)),
              ),
            ),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text("Add to cart",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFff665e))),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFff665e),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                side: BorderSide(color: Color(0xFFff665e)),
              ),
            ),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text("Available at shops",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final ProductDetails productDetails;

  const DetailScreen({Key? key, required this.productDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = productDetails.data.productVariants[0];

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(
            product.productImages[0],
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildInfoRow("SKU", product.sku, Colors.red),
          _buildInfoRow(
            "Price",
            product.maxPrice != null ? "VND ${product.maxPrice}" : "Unavailable",
            product.maxPrice != null ? const Color(0xFFf67426) : const Color(0xFF0dc2cd),
          ),
          _buildDescriptionSection("Description", product.productDescription),
          _buildSpecificationSection(context, productDetails.data.productSpecifications),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title.toUpperCase(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF565656))),
          Text(value.toUpperCase(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color)),
          const Icon(Icons.arrow_forward_ios, color: Color(0xFF999999)),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String title, String description) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF565656))),
          const SizedBox(height: 15),
          Text(description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF4c4c4c))),
        ],
      ),
    );
  }

  Widget _buildSpecificationSection(BuildContext context, List<ProductSpecification> specifications) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Specification",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF565656))),
          const SizedBox(height: 15),
          Column(
            children: specifications.map((spec) {
              return Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(spec.specificationName, style: const TextStyle(fontSize: 14, color: Color(0xFF444444))),
                    Text(spec.specificationValue, style: const TextStyle(fontSize: 14, color: Color(0xFF212121))),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

Future<ProductDetails> getDetailData(String slug) async {
  final response = await http.get(Uri.parse('${Urls.CORE_BASE_URL}$slug'));

  if (response.statusCode == 200) {
    return ProductDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load product details");
  }
}

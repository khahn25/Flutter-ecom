import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:food_delivery/common_widget/CircularProgress.dart';
import 'package:food_delivery/common_widget/GridTilesCategory.dart';

import 'package:food_delivery/utils/Urls.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import "../models/BranchModel.dart";

// BrandModel brandModel = BrandModel(results: []);

class BrandHomePage extends StatefulWidget {
  String slug;
  bool isSubList;

  BrandHomePage({Key? key,
   required this.slug, 
   this.isSubList=false}) : super(key: key);
  @override
  _BrandHomePageState createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<BrandHomePage> {
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoryList(widget.slug,widget.isSubList),
      builder: (context, AsyncSnapshot snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return Center(child: Text("No brands available."));
        } else {
          return createListView(context, snapshot.data!);
        }
      },
    );
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  BrandModel values = snapshot.data;
  List<Results> results = values.results;

  return GridView.count(
    crossAxisCount: 3,
    padding: EdgeInsets.all(1.0),
    childAspectRatio: 8.0 / 9.0,
    // children: List<Widget>.generate(results.length, (index) {
    //   return GridTile(
    //       child: GridTilesCategory(
    //           name: results[index].name ?? 'No name',
    //           imageUrl: results[index].imageUrl?.toString() ?? '',
    //           slug: results[index].slug ?? ''));
    // }),
  );
}

Future<BrandModel> getCategoryList(String slug, bool isSubList) async {
  final response = await http.get(Uri.parse("${Urls.CORE_BASE_URL}$slug"));

  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    log("API Response: $body");
    return BrandModel.fromJson(body);
  } else {
    throw Exception("Failed to load brand data");
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery/components/BrandHomePage.dart';
import 'package:food_delivery/components/CategorySlider.dart';
import 'package:food_delivery/common_widget/PopularMenu.dart';
import 'package:food_delivery/common_widget/SearchWidget.dart';
import 'package:food_delivery/common_widget/TopPromoSlider.dart';
import 'package:food_delivery/components/ShopHomePage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SearchWidget(),
          TopPromoSlider(),
          PopularMenu(),
          SizedBox(
            height: 10,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Categories',
                ),
                Tab(
                  text: 'Brands',
                ),
                Tab(
                  text: 'Shops',
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              color: Color(0xFFf5f6f7),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  color: Colors.white24,
                  child: CategoryPage(slug: 'categories'),
                ),
                Container(
                  color: Colors.white24,
                  child: BrandHomePage(slug: 'public/shop/brands/'),
                ),
                Container(
                  color: Colors.white24,
                  child: ShopHomePage(
                    slug: '/shops/?page=1&limit=5',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

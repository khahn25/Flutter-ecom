import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/AppBarWidget.dart';
import 'package:food_delivery/components/BrandHomePage.dart';
import 'package:food_delivery/components/CategorySlider.dart';
import 'package:food_delivery/common_widget/BottomNavBarWidget.dart';
import 'package:food_delivery/common_widget/SearchWidget.dart';
import 'package:food_delivery/components/ShopHomePage.dart';

class SubCategoryScreen extends StatelessWidget {
  final String slug;

  const SubCategoryScreen({Key? key, required this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(context),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SearchWidget(),
              const SizedBox(
                height: 10,
                child: ColoredBox(color: Color(0xFFf5f6f7)),
              ),
              PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: const TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Sub Categories'),
                    Tab(text: 'Brands'),
                    Tab(text: 'Shops'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
                child: ColoredBox(color: Color(0xFFf5f6f7)),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // CategoryPage(slug: 'categories/?parent=$slug', isSubList: true),
                    BrandHomePage(slug: 'brands/?limit=20&page=1&category=$slug', isSubList: true),
                    // ShopHomePage(slug: 'category/shops/$slug/?page=1&limit=15', isSubList: true),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(), // Xóa `const` nếu có trạng thái
      ),
    );
  }
}

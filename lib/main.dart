
import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/AppBarWidget.dart';
import 'package:food_delivery/components/AppSignIn.dart';
import 'package:food_delivery/screens/HomeScreen.dart';
import 'package:food_delivery/common_widget/BottomNavBarWidget.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),  // Màn hình đăng nhập
    );
  }
}


int currentIndex = 0;
void navigateToScreens(int index) {
  currentIndex = index;
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageNewState createState() => _MyHomePageNewState();
}

class _MyHomePageNewState extends State<MyHomePage> {
  final List<Widget> viewContainer = [
    HomeScreen(),
    // WishListScreen(),
    // ShoppingCartScreen(),
    HomeScreen()
  ];

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(context),
        // drawer: DrawerWidget(),
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
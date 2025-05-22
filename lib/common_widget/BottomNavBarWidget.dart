import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_delivery/main.dart';
import 'package:food_delivery/screens/WishListScreen.dart';
import 'package:food_delivery/screens/ShoppingCartScreen.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;

  void navigateToScreens(int index) {
    Widget screen;
    switch (index) {
      case 0:
        screen = MyHomePage(); 
        break;
      case 1:
        screen = WishListScreen(); 
        break;
      case 2:
        screen = ShoppingCartScreen();
        break;
      case 3:
        screen = Scaffold( 
          appBar: AppBar(title: Text('Dashboard')),
          body: Center(child: Text('Dashboard Page')),
        );
        break;
      default:
        screen = MyHomePage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      navigateToScreens(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.heart),
          label: 'Wish List',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.shoppingBag),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.dashcube),
          label: 'Dashboard',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Color(0xFF545454),
      selectedItemColor: Color(0xFFAA292E),
      onTap: _onItemTapped,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery/main.dart';
import 'package:food_delivery/screens/ShoppingCartScreen.dart';
import 'package:food_delivery/screens/TermsConditionsScreen.dart';
import 'package:food_delivery/screens/WishListScreen.dart';
import 'package:food_delivery/components/AppSignIn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createDrawerHeader(),
            _createDrawerItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    )),
            _createDrawerItem(
                icon: FontAwesomeIcons.user,
                text: 'Sign In',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppSignIn()),
                    )),
            _createDrawerItem(
                icon: Icons.favorite_border,
                text: 'Wish List',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishListScreen()),
                    )),
            _createDrawerItem(
                icon: Icons.call,
                text: 'Contact Us',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmptyWishListScreen()),
                    )),
            _createDrawerItem(
                icon: Icons.shopping_cart,
                text: 'Shopping',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCartScreen()),
                    )),
            _createDrawerItem(
                icon: Icons.pause_presentation,
                text: 'Terms & Conditions ',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsConditionsScreen()),
                    )),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Image.asset(
              'assets/images/hehe.png',
              width: 130,
              height: 130,
            ),
          ),
        ),
        Positioned(
            bottom: 12.0,
            left: 17.0,
            child: Text("Developed for learing purpose by 'Xuankhanh'",
                style: TextStyle(
                    color: Color(0xFF545454),
                    fontSize: 9.0,
                    fontWeight: FontWeight.w500)
                  )
        ),
      ]
    )
  );
}

Widget _createDrawerItem(
    {required IconData icon, 
     required String text, 
     required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Color(0xFF808080),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text,
            style: TextStyle(color: Color(0xFF484848)),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

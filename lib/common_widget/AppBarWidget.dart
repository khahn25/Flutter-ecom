import 'package:flutter/material.dart';
import 'package:food_delivery/components/AppSignIn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



PreferredSizeWidget appBarWidget(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    title: Image.asset(
      "assets/images/hehe.png",
      width: 100,
      height: 50,
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppSignIn()),
          );
        },
        icon: Icon(FontAwesomeIcons.user),
        color: Color(0xFF323232),
      ),
    ],
  );
}

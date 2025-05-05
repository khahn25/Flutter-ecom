import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/screens/HomeScreen.dart';
import 'package:food_delivery/screens/WishListScreen.dart';
import 'package:food_delivery/screens/ShoppingCartScreen.dart';
import 'package:food_delivery/common_widget/DrawerWidget.dart';
import 'package:food_delivery/common_widget/AppBarWidget.dart';
import 'package:food_delivery/common_widget/BottomNavBarWidget.dart';
import 'package:food_delivery/components/AppSignIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // khởi tạo Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AuthGate(),
    );
  }
}

/// Giao diện điều hướng dựa trên trạng thái đăng nhập
class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return MyHomePage(); // đã đăng nhập
        } else {
          return AppSignIn(); // chưa đăng nhập
        }
      },
    );
  }
}

int currentIndex = 0;

/// Sử dụng để điều hướng giữa các tab
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
    WishListScreen(),
    ShoppingCartScreen(),
    DrawerWidget(),
    HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(context),
        drawer: DrawerWidget(),
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}

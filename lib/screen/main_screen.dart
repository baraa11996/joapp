import 'package:flutter/material.dart';
import '../models/bn_screen.dart';
import 'bn_screen/card_screen.dart';
import 'bn_screen/category_screen.dart';
import 'bn_screen/emp_screen.dart';
import 'bn_screen/profile_screen.dart';
import 'home_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;
  @override
  // final List<BnScreen> _bnScreen = <BnScreen> ;
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        BnScreen(title: 'Category', widget: CategoryScreen()),
        BnScreen(title: 'Cart', widget: CardScreen()),
        BnScreen(title: 'Home', widget: HomeScreen()),
        BnScreen(title: 'Order', widget: EmpScreen()),
        BnScreen(title: 'profile', widget: ProfileScreen()),
      ][_currentIndex].widget,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
        color: Colors.grey.shade300,
        height: 60,
        backgroundColor: Colors.white70,
        index: _currentIndex,
        items: <Widget>[
          Icon(Icons.category, size: 30,color: _currentIndex == 0 ? Color(0xFF042C4C) :Colors.grey,),
          Icon(Icons.shopping_cart, size: 30,color: _currentIndex == 1 ? Color(0xFF042C4C) :Colors.grey,),
          Icon(Icons.home, size: 30,color: _currentIndex == 2 ? Color(0xFF042C4C) :Colors.grey,),
          Icon(Icons.shop, size: 30,color: _currentIndex == 3 ? Color(0xFF042C4C) :Colors.grey,),
          Icon(Icons.perm_identity, size: 30,color: _currentIndex == 4 ? Color(0xFF042C4C) :Colors.grey,),
        ],
      ),
    );
  }
}

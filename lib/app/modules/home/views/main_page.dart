import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile25/app/modules/home/views/account_page.dart';
import 'package:mobile25/app/modules/home/views/coin_page.dart';
import 'home_page.dart';
import 'api_page.dart';
import 'home_page.dart';
import 'webview_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomePage(), ApiPage(), AccountPage(), CoinPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "news"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.currency_bitcoin), label: "Coin")
        ],
      ),
    );
  }
}

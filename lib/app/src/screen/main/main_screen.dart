import 'package:flu_shop_search/app/src/screen/home/home_screen.dart';
import 'package:flu_shop_search/app/src/screen/map/map_screen.dart';
import 'package:flu_shop_search/app/src/screen/myinfo/my_info_screen.dart';
import 'package:flu_shop_search/app/src/screen/search/search_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> screenType = [
    HomeScreen(),
    SearchScreen(),
    MapScreen(),
    MyInfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Main Screen')),
      body: screenType.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType
            .fixed, // fiexd 타입이 아니면 item이 4개 부터는 배경이 하얗게 된다
        backgroundColor: Colors.white,
        // selectedItemColor: Color(0xff14FF00),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'map'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'myinfo'),
        ],
      ),
    );
  }
}

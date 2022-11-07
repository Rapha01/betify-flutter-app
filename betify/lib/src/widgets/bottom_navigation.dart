import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
  
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Profile'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Settings'
            )
          ]
        );
  }
}
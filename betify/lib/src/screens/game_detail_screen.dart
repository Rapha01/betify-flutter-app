import 'package:flutter/material.dart';
import 'package:betify/src/widgets/bottom_navigation.dart';

class GameDetailScreen extends StatelessWidget {
  static final String route = 'gameDetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('I am GameDetail'),
      appBar: AppBar(
        title: Text('Game Detail')
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:betify/src/screens/game_detail_screen.dart';
import 'package:betify/src/screens/games_list_screen.dart';

import 'src/screens/counter_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.purple,),
      //home: CounterHomeScreen(title: 'MyApp'),
      home: GamesListScreen(),
      routes: {
        GameDetailScreen.route: (context) => GameDetailScreen()
      }
    );
  }
}
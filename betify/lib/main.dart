import 'package:betify/src/blocs/counter_bloc.dart';
import 'package:betify/src/screens/betify_home_screen.dart';
import 'package:betify/src/screens/game_detail_screen.dart';
import 'package:betify/src/screens/login_screen.dart';
import 'package:betify/src/screens/register_screen.dart';
import 'package:betify/src/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config.dart';
import 'src/screens/counter_screen.dart';

void main() {
  Config().initConfig();
  runApp(AppStore(child: const MyApp()));
}

final _router = GoRouter(
  initialLocation: '/counter_example',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BetifyHomeScreen(),
      routes: [
        GoRoute(
          path: 'game/:gameId',
          builder: (context, state) => GameDetailScreen(id: state.params['gameId']),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => LoginScreen(message: state.queryParams['message']),
        ),
        GoRoute(
          path: 'register',
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: 'counter_example',
          builder: (context, state) => CounterScreen(title: 'Counter Example', counterBloc: CounterBlocProvider.of(context)),
        ),
      ]
    ),
    /*GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(
          path: 'register',
          builder: (context, state) => RegisterScreen(),
        ),
      ]
    ), */
  ],
);

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      title: 'Betify'
    );
  }

  /*Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      //home: BetifyHomeScreen(),
      /*routes: {
        GameDetailScreen.route: (context) => GameDetailScreen()
      }*/
      /*onGenerateRoute: (RouteSettings settings) {
        if (settings.name == GameDetailScreen.route) {
          final Map<String,String> arguments = settings.arguments as Map<String,String>;


          return MaterialPageRoute(
            builder: (context) => GameDetailScreen(id: arguments['id'] ?? '-1')
          );
        }
      },*/
    );
  }*/
}
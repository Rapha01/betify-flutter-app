import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class MyToast extends StatefulWidget {

  MyToast({Key? key}): super(key: key);

  @override
  _MyToastState createState() => _MyToastState();
}

class _MyToastState extends State<MyToast> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
      ),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
          Icon(Icons.check),
          SizedBox(
          width: 12.0,
          ),
          Text("This is a Custom Toast"),
      ],
      ),
    );


    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
    
  // Custom Toast Position
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: 16.0,
          left: 16.0,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        child: const Text('Go to Login Screen'),
        onPressed: () {
          context.go('/login');
        }
      ),
      appBar: AppBar(title: Text('Register')),
    );
  }
}
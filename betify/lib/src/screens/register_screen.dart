import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {

  RegisterScreen({Key? key}): super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
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
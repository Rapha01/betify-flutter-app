import 'package:betify/src/models/forms.dart';
import 'package:betify/src/services/auth_api_service.dart';
import 'package:betify/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}): super(key: key);
  final AuthApiService authApi = AuthApiService();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey = GlobalKey<FormFieldState<String>>();

  final LoginFormData _loginData = LoginFormData();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() async {
    try {
        final data = await widget.authApi.login(_loginData);

        print('login response: ${data}');

        context.go('/');
      } catch (e) {
        var snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
  }

  _submit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      _login();

      print('${_loginData.password} ${_loginData.email}');
    } else {
      setState(() { autoValidate = AutovalidateMode.onUserInteraction;});
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: autoValidate,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold 
                  ),
                ),
              ),
              TextFormField(
                key: _emailKey,
                style: Theme.of(context).textTheme.headline4,
                validator: emailValidator,
                onSaved: (newValue) { _loginData.email = newValue ?? ''; },
                decoration: const InputDecoration(
                  hintText: 'Email Address'
                ),
                initialValue: 'opera@opera.com',
              ),
              TextFormField(
                key: _passwordKey,
                style: Theme.of(context).textTheme.headline4,
                obscureText: true,
                validator: passwordValidator,
                onSaved: (newValue) { _loginData.password = newValue ?? ''; },
                decoration: const InputDecoration(
                  hintText: 'Password'
                ),
                initialValue: 'qayqay12',
              ),
              _buildLinks(),
              Container(
                alignment: const Alignment(-1.0, 0.0),
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(
                      color: Colors.white
                    )
                  ),
                  onPressed: _submit,
                  child: const Text('Submit'),
                )
              ),
            ],
          ),
        )
      ),
      appBar: AppBar(title: const Text('Login')),
    );
  }

  _buildLinks() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap:() => { context.go('/login/register') },
            child: Text(
              'Not registered yet? Resgister now!',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              ),
            )
          ),
          GestureDetector(
            onTap:() => { context.go('/') },
            child: Text(
              'Continue to Main Page',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              ),
            )
          )
        ],
      )
    );
  }
}



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/forms.dart';
import '../services/auth_api_service.dart';
import '../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}): super(key: key);
  final AuthApiService authApi = AuthApiService();

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RegisterFormData _registerData = RegisterFormData();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  void _handleSuccess(data) {
    print('register response: ${data}');
    context.go('/login?message=Registration successfull. You can log in now!');
  }

  void _handleError(error) {
    var snackBar = const SnackBar(content: Text('Registration successfull.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _submit() {
    final form = _formKey.currentState;
    
    if (form!.validate()) {
      form.save();

      widget.authApi
        .register(_registerData)
        .then(_handleSuccess)
        .catchError(_handleError);

    } else {
      setState(() { autoValidate = AutovalidateMode.onUserInteraction;});
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final String nowTemp = '${now.month}${now.day}${now.hour}${now.minute}${now.second}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register')
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              autovalidateMode: autoValidate,
              child: ListView(
                children: [
                  _buildTitle(),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline4,
                    validator: usernameValidator,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    onSaved: (newValue) => _registerData.username = newValue ?? '',
                    initialValue: 'username$nowTemp',
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline4,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => _registerData.email = newValue ?? '',
                    initialValue: '$nowTemp@test.com',
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline4,
                    validator: passwordValidator,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (newValue) => _registerData.password = newValue ?? '',
                    initialValue: 'qayqay12',
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline4,
                    validator: confirmPasswordValidator,
                    decoration: const InputDecoration(
                      hintText: 'Password Confirmation',
                    ),
                    obscureText: true,
                    onSaved: (newValue) => _registerData.passwordConfirmation = newValue ?? '',
                    initialValue: 'qayqay12',
                  ),
                  _buildLinksSection(),
                  _buildSubmitBtn()
                ],
              ),
            )
          );
        }
      )
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: const Text(
        'Register',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      alignment: const Alignment(-1.0, 0.0),
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
    );
  }

  Widget _buildLinksSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              context.go('/login');
            },
            child: Text(
              'Already Registered? Login Now.',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: Text(
              'Continue to Home Page',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            )
          )
        ],
      ),
    );
  }
}




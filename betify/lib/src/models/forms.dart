import 'dart:convert';

class LoginFormData {
  String email = '';
  String password = '';
  
  String toJSON() {
   return json.encode({
      'email': email,
      'password': password
    });
  }
}

class RegisterFormData {
  String email = '';
  String username = '';
  String password = '';
  String passwordConfirmation = '';

  String toJSON() {
   return json.encode({
    'email': email,
    'username': username,
    'password': password,
    });
  }
}
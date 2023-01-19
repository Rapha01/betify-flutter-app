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
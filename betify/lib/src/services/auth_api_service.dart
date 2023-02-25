import 'dart:convert';
import 'package:betify/src/models/forms.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../models/users.dart';
import '../utils/jwt.dart';


class AuthApiService {
  static final AuthApiService _singleton = AuthApiService._internal();
  factory AuthApiService() => _singleton;
  AuthApiService._internal();
  
  String? _token;
  User? _user;

  Future<bool> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _token = token;
    return true;
  }

  Future<String?> _getToken() async {
    if (_token != null) {
      return _token;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null || token == '')
        return null;
      else 
        return token;
    }
  }

  bool _saveUser(Map<String, dynamic> data) {
    _user = User.fromMap(data);

    return true;
  }

  Future<User?> getUser() async {
    final String? token = await _getToken();
    if (token == null) 
      return null;

    if (_user != null) 
      return _user;

    try {
      final resUser = await http.post(Uri.parse('${Config().apiUrl}/users/me'), headers: {'Content-Type': 'application/json', 'authorization': 'Bearer $token'});
      final Map<String,dynamic> parsedData = Map<String,dynamic>.from(json.decode(resUser.body));

      if (resUser.statusCode == 200) {
        _saveUser(parsedData);
        return _user;
      } else {
        throw parsedData['message'];
      }

    } catch (e) {
      return Future.error(e);
    }
  }

  _removeAuthData() {
    
  }

  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      _token = null;
      _user = null;

      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String,dynamic>> login(LoginFormData loginData) async {
    final body = loginData.toJSON();
    final resLogin = await http.post(Uri.parse('${Config().apiUrl}/auth/login'), headers: {'Content-Type': 'application/json'}, body: body);

    final Map<String,dynamic> parsedData = Map<String,dynamic>.from(json.decode(resLogin.body));

    if (resLogin.statusCode == 200) {
      _saveToken(parsedData['tokens']['access']['token']);
      _saveUser(parsedData['user']);

      print('Logged in user: ${_user.toString()}');

      return parsedData;
    } else {
      return Future.error(parsedData['message']);
    }
  }

  Future<bool> register(RegisterFormData registerData) async {
    final body = registerData.toJSON();
    final resRegister = await http.post(Uri.parse('${Config().apiUrl}/auth/register'), headers: {'Content-Type': 'application/json'}, body: body);

    final Map<String,dynamic> parsedData = Map<String,dynamic>.from(json.decode(resRegister.body));

    if (resRegister.statusCode == 201) {
      print('Registered user: ${_user.toString()}');

      return true;
    } else {
      return Future.error(parsedData['message']);
    }
  }
}
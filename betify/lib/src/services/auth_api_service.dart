import 'dart:convert';
import 'package:betify/src/models/forms.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../models/users.dart';


class AuthApiService {
  static final AuthApiService _singleton = AuthApiService._internal();
  factory AuthApiService() => _singleton;
  AuthApiService._internal();
  
  String? _token;
  User? user;

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
    user = User.fromMap(data);

    return true;
  }

  Future<bool> isAuthenticated() async {
    if ((await _getToken()) != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String,dynamic>> login(LoginFormData loginData) async {
    final body = loginData.toJSON();
    final resLogin = await http.post(Uri.parse('${Config().apiUrl}/auth/login'), headers: {'Content-Type': 'application/json'}, body: body);

    final Map<String,dynamic> parsedData = Map<String,dynamic>.from(json.decode(resLogin.body));

    if (resLogin.statusCode == 200) {
      _saveToken(parsedData['tokens']['access']['token']);
      _saveUser(parsedData['user']);

      print('ZZZZZZZZZZ: ${user.toString()}');

      return parsedData;
    } else {
      return Future.error(parsedData['message']);
    }
  }
}
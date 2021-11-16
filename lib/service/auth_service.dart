import 'dart:convert';

import 'package:coba_aja/models/register.dart';
import 'package:http/http.dart' as http;
import 'package:coba_aja/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = "http://localhost:8000";
  // final prefs = await SharedPreferences.getInstance();

  login(Login login) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/login'),
    );
    request.fields['username'] = login.email;
    request.fields['password'] = login.password;
    final response = await request.send();

    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsed.body);
      var token = data['jwtToken'];
      print(token);
      this._save(token);
      return token;
    } else {
      return null;
    }
  }

  // Future<Login> login(Login login) async {
  //   // Map data = {'username': login.email, 'password': login.password};

  //   final response = await http.post(
  //       Uri.parse('http://a564-103-217-219-197.ngrok.io/login'),
  //       headers: {"Content-Type": "multipart/form-data"},
  //       body: {'username': login.email, 'password': login.password});
  //   var coba = json.decode(response.body);

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

  //     this._save(coba['jwtToken']);

  //     return parsed.map<Login>((json) => Login.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load Login');
  //   }
  // }

  Future<List<Register>> register() async {
    final response = await http.post(Uri.parse('${this.apiUrl}/employee'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      print(response.body);

      return parsed.map<Register>((json) => Register.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Login');
    }
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString("token", token);
  }
}

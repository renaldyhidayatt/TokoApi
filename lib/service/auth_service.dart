import 'dart:convert';

import 'package:coba_aja/helpers/user_info.dart';
import 'package:coba_aja/models/register.dart';
import 'package:http/http.dart' as http;
import 'package:coba_aja/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = "http://localhost:8000";
  final UserInfo userinfo = UserInfo();
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
      this.userinfo.setToken(token);
      this.userinfo.setUserId(data['id'].toString());

      return token;
    } else {
      return null;
    }
  }

  register(Register register) async {
    Map data = {
      'nama': register.nama,
      'email': register.email,
      'password': register.password
    };

    final response = await http.post(Uri.parse('${this.apiUrl}/employee'),
        headers: {'Accept': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      print(response.body);

      return parsed.map<Register>((json) => Register.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Login');
    }
  }
}

import 'dart:convert';

import 'package:coba_aja/models/member.dart';
import 'package:http/http.dart' as http;

class MemberService {
  final String apiUrl = "http://localhost:8000";

  Future<Member> fetchId(String id) async {
    final response = await http.get(Uri.parse('${this.apiUrl}/member/$id'));

    if (response.statusCode == 200) {
      return Member.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to getid";
    }
  }
}

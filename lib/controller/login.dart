import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_project/model/user.dart';

class LoginController {
  Future<bool> fetchUser(User user) async {
    String url = 'https://hrd.enseval.com:8082/HCM_API_demo/api/ERF/demoLogin/';
    var jsonBody = welcomeToJson(user);
    final response = await http.post(
      Uri.parse(url),
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(jsonDecode(response.body));
    if (response.statusCode == 200 && jsonDecode(response.body) == "SUCCEED") {
      return true;
    }
    return false;
  }
}

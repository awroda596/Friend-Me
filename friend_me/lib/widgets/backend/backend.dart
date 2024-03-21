import 'dart:convert';
import 'package:friend_me/widgets/backend/user.dart';
import 'package:http/http.dart' as http;


// ignore: camel_case_types
class Backend  {
  
  Future<http.Response> Login (String _username, String _password){
    var response;  // http request for login
    return response; // return json auth
  }
  
  Future<http.Response> register (User user) {
    var uri = Uri.http('127.0.0.1:8000', '/api/users/signup/');
    var response = http.post(uri, 
     headers: {
    "Accept": "application/json",
    "Content-Type":"application/json",
    },
      body: jsonEncode(user.toJson()));
      return response;
  }
  

}

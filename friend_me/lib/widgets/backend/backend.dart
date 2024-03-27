import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:friend_me/widgets/backend/user.dart';
import 'package:http/http.dart' as http;


// ignore: camel_case_types
class Backend  {
  

  // function to send login request
  Future<http.Response> login (String email, String password){
      var uri = Uri.http('127.0.0.1:8000', '/api/users/login/'); // sets address
    Future<http.Response> response;
     try{ // try
        response = http.post(uri, // post 
        headers: {
          "Accept": "application/json",
          "Content-Type":"application/json",
        },
        body: jsonEncode({'email': email, 'password': password})).timeout(const Duration(seconds: 10)); // post with timeout
        return response; // return response
     } on TimeoutException catch (e){
       Future<http.Response> response = Future.any([
          Future.value(http.Response("Timeout: $e", 400)),
        ]);
       if (kDebugMode) {
         print(e);
       }
       return response;
     } on Error catch (e){
         Future<http.Response> response = Future.any([
          Future.value(http.Response("Error: $e", 400)),
        ]);
        return response;
     } 
  }
  
  Future<http.Response> register (User user) {
    var uri = Uri.http('127.0.0.1:8000', '/api/users/signup/');
    Future<http.Response> response;
     try{
        response = http.post(uri, 
        headers: {
          "Accept": "application/json",
          "Content-Type":"application/json",
        },
        body: jsonEncode(user.toJson())).timeout(const Duration(seconds: 10));
        return response;
     } on TimeoutException catch (e){
       Future<http.Response> response = Future.any([
          Future.value(http.Response("Timeout: $e", 400)),
        ]);
       if (kDebugMode) {
         print(e);
       }
       return response;
     } on Error catch (e){
         Future<http.Response> response = Future.any([
          Future.value(http.Response("Error: $e", 400)),
        ]);
        return response;
     } 
  }
}

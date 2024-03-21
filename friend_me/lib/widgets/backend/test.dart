import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// ignore: camel_case_types
class backendIntegration  {
  
   final String username = "mahibbard";
  final String email = "Test@nothing.com";
  final String first_name = "max";
  final String last_name = "hib";
  final String password = "123abc";


  Future<void> test () async{


    var uri = Uri.http('127.0.0.1:8000', '/api/users/signup/');
    var response = await http.post(uri, 
     headers: {
    //"Access-Control-Allow-Origin": "*",
    "Accept": "application/json",
    "Content-Type":"application/json",
    },
      body: jsonEncode({"username": username, "email": email, "first_name": first_name, "last_name": last_name, "password": password}));
  }

}

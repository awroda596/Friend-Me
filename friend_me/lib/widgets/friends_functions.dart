import 'package:flutter/material.dart';
import '../auth/user.dart'; 
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




Future<http.Response> GetFriends(String? Email) async {
  print("getting events"); 
  var url = Uri(
    scheme: 'http',
    host: '127.0.0.1',
    port: 8000,
    path: 'getfriends',
    queryParameters: {'email' : '$Email'},
  );
  print(url); 
  http.Response response = await http.get(
    url,
    headers: {
      'Authorization': '$Email',
    },
  );
  if (response.statusCode != 200){
    return response; 
  }
 return response;
}

DecodeFriends(http.Response response){
  
}

//friend class based on 
class Friend{

}





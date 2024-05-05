import 'package:flutter/material.dart';
import '../auth/user.dart'; 
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// http.get method to fetch users. 
//querystring = { QueryType : QueryParam}.  leave these null if not using querystring. 
// pass response to listFriends to get a list. 
Future<http.Response> fetchUsers(String? UID, String? QueryType, String? QueryParam) async {
  String? host = '127.0.0.1'; 
  int? port = 8000; 
  String? path = 'getusers'; //placeholder url, replace with backend url. 
  late Uri url; 
  if(QueryType == null){
    url = Uri(
    scheme: 'http',
    host: host,
    port: port,
    path: path,
  );
  }
  else{
    url = Uri(scheme: 'http', host: host, port: port, path: path, queryParameters: {'$QueryType' : '$QueryParam'},);
  }
  print(url); 
  http.Response response = await http.get(
    url,
    headers: {
      'Authorization': '$UID',
    },
  );
  if (response.statusCode != 200){
    return response; 
  }
 return response;
}

//fetch all friends from backend using http get.
//pass response (if valid) to listFriends to get a list. 
Future<http.Response> fetchFriends(String? UID) async {
  String? host = '127.0.0.1'; 
  int? port = 8000; 
  String path = 'getfriends'; //placeholder url, replace with backend url. 
  var url = Uri(
    scheme: 'http',
    host: host,
    port: port,
    path: path,
  );

  print(url); 
  http.Response response = await http.get(
    url,
    headers: {
      'Authorization': '$UID',
    },
  );
  if (response.statusCode != 200){
    return response; 
  }
 return response;
}

//decode response from FetchFriends to retrieve a list of Friends/Users
List<Friend> listFriends(http.Response response){
  Iterable list = json.decode(response.body);
  List<Friend> Friends =List<Friend>.from(list.map((model) => Friend.fromJson(model)));
  return Friends;
}

//method to add a friend using http.post.  pass the id (user table id, not actual uid) of the user you want to add)
//can change the identifier from id to username/email/etc if needed. 
Future<http.Response> addFriend(String? UID, int id) async{
  String? host = '127.0.0.1'; 
  int? port = 8000; 
  String path = 'addfriend'; //placeholder url, replace with backend url. 
  var url = Uri(
    scheme: 'http',
    host: host,
    port: port,
    path: path,
  );
  http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$UID',
    },
    body: jsonEncode(<String, String>{
      'UID': "$UID", //this user id
      'id': "$id", // Table ID (primary key) of the user to add as friend (see users_customuser table); 
      'action': "add", 
    }),
  );
  if (response.statusCode != 200 && response.statusCode != 201){
    return response; 
  }
  return response; 
}

//friend class based on users_customuser table.  used for both friends list and user list when searching for friend. 
class Friend{
  final int id; //might not be needed
  final String username;
  final String first_name; 
  final String last_name; 
  final String email; 

  Friend({required this.id, required this.username, required this.first_name, required this.last_name, required this.email}); 

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'] as int,
      username: json['username'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String, 
      email: json['email'] as String, 
    );
  }
}





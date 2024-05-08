import 'package:flutter/material.dart';
import '../auth/user.dart'; 
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//class to hold uid and Response for friends futurebuilders.
class fFutureResults {
  final http.Response Response;
  final String? uid;
  fFutureResults({required this.Response, required this.uid});
}

Future<fFutureResults> fetchFriendsandUIDoffline() async {
  final String? _uid = await getUsername();
  print("uid: $_uid");
  const data = {'text': 'text', 'value': 5};
  final String jsonstr = jsonEncode(data);
  final http.Response _response = http.Response(jsonstr,200);
  print("response: ${_response.statusCode}");
  return fFutureResults(Response: _response, uid: _uid);
}

Future<fFutureResults> fetchFriendsandUID() async {
  final String? _uid = await getUsername();
  print("uid: $_uid");
  final http.Response _response = await getFriends(_uid);
  print("response: ${_response.statusCode}");
  return fFutureResults(Response: _response, uid: _uid);
}
// http.get method to fetch users. 
//querystring = { QueryType : QueryParam}.  leave these null if not using querystring. 
// pass response to listFriends to get a list. 
Future<http.Response> getUsers(String? UID, String? QueryType, String? QueryParam) async {
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

//get all users that are friends from backend using http get.
//pass response (if valid) to listFriends to get a list. 
Future<http.Response> getFriends(String? UID) async {
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

//decode response from FetchFriends or FetchUsers to retrieve a list of Users
List<User> listUsers(http.Response? response){
  Iterable list = json.decode(response!.body);
  List<User> Users =List<User>.from(list.map((model) => User.fromJson(model)));
  return Users;
}

List<User> listUsersOffline(){
  List<User> Users = []; 
  Users.add(User(id: 1,username: "throwdowntime777",email: "bobby@foodnetwork.net",first_name: "bobby", last_name: "flay"));
  Users.add(User(id: 1,username: "timmy1992",email: "tsmith@mail.com",first_name: "Tom", last_name: "Smith"));
  Users.add(User(id: 1,username: "cptrex501st",email: "crex501@mail.com",first_name: "CT", last_name: "7567"));
  Users.add(User(id: 1,username: "bobthebuilder",email: "wecanfixit@mail.com",first_name: "Bob", last_name: "Builder"));
  Users.add(User(id: 1,username: "user223",email: "user223@mail.com",first_name: "User", last_name: "Name"));
  Users.add(User(id: 1,username: "WorldsBestBoss",email: "mscott@dundermifflin.com",first_name: "Michael", last_name: "Scott"));
  Users.add(User(id: 1,username: "user4924",email: "user4024@mail.com",first_name: "user", last_name: "name2"));
  return Users; 
}

//method to add a friend using http.post.  pass the id (user table id, not actual uid) of the user you want to add)
//can change the identifier from id to username/email/etc if needed. 
Future<http.Response> addFriend(String? UID, String? identifier) async{
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
      'target': "$identifier", //identifying variable of another user. (username/table id)
    }),
  );
  if (response.statusCode != 200 && response.statusCode != 201){
    return response; 
  }
  return response; 
}

//method to respond to a friend request from table profiles_friendrequest.  
//take status and appropriately change the status of friend request in table. 
Future<http.Response> respondFriendReqeusts(String? UID, int id, String? frResponse) async{
  String? host = '127.0.0.1'; 
  int? port = 8000; 
  String path = 'respondfr'; //placeholder url, replace with backend url. 
  var url = Uri(
    scheme: 'http',
    host: host,
    port: port,
    path: path,
  );
  http.Response response = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$UID',
    },
    body: jsonEncode(<String, String>{
      'id': "$id", //PK  id of a friend request.  
      'status': "$frResponse",
    }),
  );
  if (response.statusCode != 200 && response.statusCode != 201){
    return response; 
  }
  return response; 
}

Future<http.Response> getFriendRequests(String? UID) async {
  String? host = '127.0.0.1'; 
  int? port = 8000; 
  String path = 'getfriends'; //placeholder url, replace with backend url. 
  var url = Uri(
    scheme: 'http',
    host: host,
    port: port,
    path: path,
    queryParameters: {'UID' : '$UID'}, //own user id as query string.
  );
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

List<friendRequest> ListMeetUps(http.Response response){
  Iterable list = json.decode(response.body);
  List<friendRequest> friendRequests =List<friendRequest>.from(list.map((model) => friendRequest.fromJson(model)));
  return friendRequests;
}

//class to hold recieved/pendin friend requests.
class friendRequest{
  final int id; //table identifier for request\
  final DateTime created_at;
  final String status; 
  final String from_user_id;
  final String to_user_id; //redundant, we know it's to us, backend knows from the auth header

  friendRequest({
  required this.id, 
  required this.created_at, 
  required this.status,
  required this.from_user_id,
  required this.to_user_id,
  }); 

  factory friendRequest.fromJson(Map<String, dynamic> json) {
    return friendRequest(
      id: json['id'] as int,
      created_at: DateTime.parse(json['created_at'].toString()),
      status: json['status'] as String,
      from_user_id: json['from_user_id'] as String,
      to_user_id: json['to_user_id'] as String, 
    );
  }
}

//user class based on users_customuser table.  used for both friends list and user list when searching for friend. 
class User{
  final int id; //might not be needed
  final String username;
  final String first_name; 
  final String last_name; 
  final String email; 

  User({required this.id, required this.username, required this.first_name, required this.last_name, required this.email}); 

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String, 
      email: json['email'] as String, 
    );
  }
}





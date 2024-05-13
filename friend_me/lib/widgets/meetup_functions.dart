//functions revolving around meetup times
import 'package:flutter/material.dart';
import '../auth/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//hold UID and http response for our future builder
class mFutureResults {
  final http.Response Response;
  final String? uid;
  mFutureResults({required this.Response, required this.uid});
}

Future<mFutureResults> fetchMeetupsAndUIDdebug() async {
  final String? _uid = await getUsername();
  print("uid: $_uid");
  const data = {'text': 'text', 'value': 5};
  final String jsonstr = jsonEncode(data);
  final http.Response _response = http.Response(jsonstr, 200);
  print("response: ${_response.statusCode}");
  return mFutureResults(Response: _response, uid: _uid);
}

Future<mFutureResults> fetchMeetupsAndUID() async {
  final String? _uid = await getUsername();
  print("uid: $_uid");
  final http.Response _response = await getMeetUps(_uid);
  print("response: ${_response.statusCode}");
  return mFutureResults(Response: _response, uid: _uid);
}

//Function to respond to a meetup (acccept/decline/etc.).  sends UID, id (meetup id), and userresponse to back end
Future<http.Response> respondToMeetUp(
    String? UserResponse, String? UID, int id) async {
  var url = Uri(
    scheme: 'http',
    host: '127.0.0.1',
    port: 8000,
    path: 'meetups', //placeholder url, replace with backend url.
    //queryParameters: {'UID' : '$UID'}, //own user id as query string.
  );
  http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$UID',
    },
    body: jsonEncode(<String, String>{
      'UID': "$UID",
      'id': "$id",
      'response': "$UserResponse",
    }),
  );
  if (response.statusCode != 200) {
    return response;
  }
  return response;
}

Future<http.Response> getMeetUps(String? uid) async {
  var url = Uri(
    scheme: 'http',
    host: '127.0.0.1',
    port: 8000,
    path: 'meetups', //placeholder url, replace with backend url.
  );
  http.Response response = await http.get(
    url,
    headers: {
      'Authorization': '$uid',
    },
  );
  if (response.statusCode != 200) {
    return response;
  }
  //List<HTTPUser> users =
  return response;
}

//pass the http response from FetchMeetups to this function to return a list of meetups
List<MeetUp> ListMeetUps(http.Response response) {
  Iterable list = json.decode(response.body);
  List<MeetUp> MeetUps =
      List<MeetUp>.from(list.map((model) => MeetUp.fromJson(model)));
  return MeetUps;
}

List<MeetUp> ListMeetUpsOffline() {
  List<MeetUp> MeetUps = [];
  MeetUps.add(MeetUp(
      id: 1,
      friend_user: "Shaddam",
      status: "confirmed",
      start_time: DateTime.parse("2024-05-07T08+00:00"),
      end_time: DateTime.parse("2024-05-07T14+00:00")));
  MeetUps.add(MeetUp(
      id: 2,
      friend_user: "Rauban",
      status: "confirmed",
      start_time: DateTime.parse("2024-05-08T10+00:00"),
      end_time: DateTime.parse("2024-05-08T12+00:00")));
  MeetUps.add(MeetUp(
      id: 3,
      friend_user: "Vladimir",
      status: "confirmed",
      start_time: DateTime.parse("2024-05-08T11+00:00"),
      end_time: DateTime.parse("2024-05-08T17+00:00")));
  MeetUps.add(MeetUp(
      id: 4,
      friend_user: "Feyd",
      status: "confirmed",
      start_time: DateTime.parse("2024-06-09T05+00:00"),
      end_time: DateTime.parse("2024-06-08T12+00:00")));
  MeetUps.add(MeetUp(
      id: 5,
      friend_user: "Chani",
      status: "confirmed",
      start_time: DateTime.parse("2024-07-09T14+00:00"),
      end_time: DateTime.parse("2024-07-08T22+00:00")));
  MeetUps.add(MeetUp(
      id: 6,
      friend_user: "Jessica",
      status: "confirmed",
      start_time: DateTime.parse("2024-08-10T10+00:00"),
      end_time: DateTime.parse("2024-08-08T12+00:00")));
  MeetUps.add(MeetUp(
      id: 7,
      friend_user: "Stilgar",
      status: "confirmed",
      start_time: DateTime.parse("2024-09-12T10+00:00"),
      end_time: DateTime.parse("2024-09-08T12+00:00")));
  MeetUps.add(MeetUp(
      id: 8,
      friend_user: "Leto",
      status: "confirmed",
      start_time: DateTime.parse("2024-09-15T10+00:00"),
      end_time: DateTime.parse("2024-09-08T12+00:00")));
  MeetUps.add(MeetUp(
      id: 9,
      friend_user: "Duncan",
      status: "confirmed",
      start_time: DateTime.parse("2024-11-20T11+00:00"),
      end_time: DateTime.parse("2024-11-20T20+00:00")));
  MeetUps.add(MeetUp(
      id: 10,
      friend_user: "Muad-Dib",
      status: "confirmed",
      start_time: DateTime.parse("2024-11-08T10+00:00"),
      end_time: DateTime.parse("2024-11-08T12+00:00")));
  return MeetUps;
}

//class meetup assuming the back end can return the username of the other friend who's time matches up, and the start/end dates (datetime) of the matching time.
class MeetUp {
  //variables: final <type> <name>
  final int id; //MeetUp id.  used for put/post to agree or cancel a MeetUp.
  final String friend_user; //name of other user in the meetup
  final String status; //status of the meet up
  final DateTime start_time;
  final DateTime end_time;
  // constructor (required this.<name>)
  MeetUp(
      {required this.id,
      required this.friend_user,
      required this.status,
      required this.start_time,
      required this.end_time});
  factory MeetUp.fromJson(Map<String, dynamic> json) {
    return MeetUp(
      id: json['id'] as int,
      friend_user: json['user'] as String,
      status: json['status'] as String,
      start_time: DateTime.parse(json['start_time'].toString()),
      end_time: DateTime.parse(['end_time'].toString()),
    );
  }
  //no map to json, MeetUps should only be created on back end in theory
}

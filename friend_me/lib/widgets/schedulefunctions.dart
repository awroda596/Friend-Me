//schedule functions.  http stuff can probably be moved into backend.dart
import 'package:friend_me/widgets/event.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:friend_me/auth/user.dart';

//Future<List<CalendarEvent<Event>>>
Future fetchEvents(CalendarEventsController controller, String? UID) async {
  //List<HTTPEvent> events = [];
  print('getting events\n');
  String url = "http://127.0.0.1:8000/eventsdetails";
  var response =
      await http.get(Uri.parse(url),
      headers: {
    'Authorization':  'put auth token here',
  },
  );
  Iterable list = json.decode(response.body);
  List<HTTPEvent> events = List<HTTPEvent>.from(list.map((model) => HTTPEvent.fromJson(model))); 
  for (var i = 0; i < events.length; i++) {
    var current = events[i];
    String start = getTime( DateTime.parse(current.start_time));
    String end = getTime( DateTime.parse(current.end_time));
    String timerange = '$start-$end';
    controller.addEvent(CalendarEvent<Event>(
        dateTimeRange: DateTimeRange(
          start: DateTime.parse(current.start_time),
          end: DateTime.parse(current.end_time),
        ),
        eventData: Event(
            title: timerange,
            description: current.details,
            color: Colors.blue)));
  }
  UID = await getUsername(); 
  return;
}

Future<http.Response> postEvent(CalendarEvent<Event> event, String? UID){
  return http.post(
    Uri.parse('http://127.0.0.1:8000/eventsdetails'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$UID',
    },
    body: jsonEncode(<String, String>{
      'creator_name': "1",
      'title': "${event.eventData?.title}",
      'start_time': "${event.dateTimeRange.start}",
      'end_time': "${event.dateTimeRange.end}",
      'description': "${event.eventData?.description}",
    }),
  );
}

String getTime(DateTime dateTime) {
  String dHour, dMinute, timeOfDay;
  if (dateTime.hour > 12) {
    dHour = "${dateTime.hour - 12}";
    timeOfDay = "PM";
  } else {
    dHour = "${dateTime.hour}";
    timeOfDay = "AM"; 
  }
  if (dateTime.minute < 10) {
    dMinute = "0${dateTime.minute}";
  } else {
    dMinute = "${dateTime.minute}";
  }
  String time = "$dHour:$dMinute$timeOfDay";
  return time;
}

DateTime getDateTime(String st){
  return DateTime.parse(st); 
}

//class to hold data from the http.get request.  may replace Event with this.
class HTTPEvent {
  final String details;
  final String start_time;
  final String end_time;
  //final int creator_id

  HTTPEvent(
      {required this.details,
      required this.start_time,
      required this.end_time});

  factory HTTPEvent.fromJson(Map<String, dynamic> json) {
    return HTTPEvent(
      details: json['description'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'description': details,
        'start_time': start_time,
        'end_time': end_time,
      };
}

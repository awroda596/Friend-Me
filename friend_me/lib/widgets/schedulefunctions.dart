//schedule functions.  http stuff can probably be moved into backend.dart
import 'dart:math';
import 'package:friend_me/widgets/event.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//Future<List<CalendarEvent<Event>>>
void fetchEvents(CalendarEventsController controller) async {
  List<HTTPEvent> events = [];
  var response =
      await http.get(Uri.parse('http://127.0.0.1:8000/eventsdetails'));
  Iterable list = json.decode(response.body);
  events = list.map((model) => HTTPEvent.fromJson(model)).toList();
  for (var i = 0; i < events.length; i++) {
    var current = events[i];
    String start = getTime(current.start_time);
    String end = getTime(current.end_time);
    String timerange = '$start-$end';
    controller.addEvent(CalendarEvent<Event>(
        dateTimeRange: DateTimeRange(
          start: current.start_time,
          end: current.end_time,
        ),
        eventData: Event(
            title: timerange,
            description: current.details,
            color: Colors.blue)));
  }
  return;
}

String getTime(DateTime DT) {
  String Hour, Minute;
  if (DT.hour > 12) {
    Hour = "${DT.hour - 12}";
  } else {
    Hour = "${DT.hour}";
  }
  if (DT.minute < 10) {
    Minute = "0${DT.minute}";
  } else {
    Minute = "${DT.minute}";
  }
  String time = "$Hour:$Minute";
  return time;
}

//class to hold data from the http.get request.  may replace Event with this.
class HTTPEvent {
  final String details;
  final DateTime start_time;
  final DateTime end_time;
  //final int creator_id

  HTTPEvent(
      {required this.details,
      required this.start_time,
      required this.end_time});

  factory HTTPEvent.fromJson(Map<String, dynamic> json) {
    return HTTPEvent(
      details: json['details'] as String,
      start_time: json['start_time'] as DateTime,
      end_time: json['end_time'] as DateTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'details': details,
        'start_time': start_time,
        'end_time': end_time,
      };
}

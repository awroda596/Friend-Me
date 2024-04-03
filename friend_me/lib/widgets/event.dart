//this defines contents of event inside of CalendarEvent<Event>>
//current CalendarEvents are used as the "free time blocks" on the schedule. 
import 'package:flutter/material.dart';

class Event {
  Event({
    required this.title,
    this.description,
    this.color,
  });

  /// The title of the [Event]. //used to show the start/end time in calendar view. 
  final String title;

  /// The description of the [Event]. unused, can likley be removed later. 
  final String? description;

  /// The color of the [Event] tile.
  final Color? color;
}
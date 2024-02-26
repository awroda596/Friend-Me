import 'package:flutter/material.dart';
import 'package:friend_me/widgets/NavBar.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:friend_me/widgets/EventCreator.dart';

class ScheduleRoute extends StatelessWidget {
  const ScheduleRoute({super.key});

  settings(){  // Does nothing right now placeholder

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: WeekView(),
    );
  }
}

import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:friend_me/widgets/schedulefunctions.dart';
import 'package:friend_me/widgets/event.dart'; 



class ScheduleRoute extends StatefulWidget {
  const ScheduleRoute({super.key});

  @override
  State<ScheduleRoute> createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute>
    with AutomaticKeepAliveClientMixin {
  //calendar and events controller
  final CalendarController<Event> controller = CalendarController();
  final CalendarEventsController<Event> eventController =
      CalendarEventsController<Event>();

  //current configuration to hold current view and list to hold week and month view.
  late ViewConfiguration currentConfiguration = viewConfigurations[0];
  List<ViewConfiguration> viewConfigurations = [
    WeekConfiguration(),
    MonthConfiguration(),
    //MultiWeekConfiguration( numberOfWeeks: 3, ),
  ];

  @override


  /* get events from backend

  Future<List<CalendarEvent<Event>>> fetchEvents(eventsController) async{
    final response = await http.get(Uri.parse('https://127.0.0.1:8000/eventdetails'))
    if (response.statusCode == 200) {
    List<CalendarEvent<Event>>  djangoEvents;
    // If the server did return a 200 OK response,
    // parse data and fill list
    //for loop
    } else {
      // If no 200 response, throw exception
      throw Exception('Failed to load events');
    }  
  } */

  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    //final List<CalendarEvent<Event>> myEvents = fetchEvents(eventsController);  //load events from Django
  }

  @override
  Widget build(BuildContext context) {
    final calendar = CalendarView<Event>(
      controller: controller,
      eventsController: eventController,
      viewConfiguration: currentConfiguration,
      tileBuilder: _tileBuilder,
      multiDayTileBuilder: _multiDayTileBuilder,
      scheduleTileBuilder: _scheduleTileBuilder,
      components: CalendarComponents(
        calendarHeaderBuilder: _calendarHeader,
      ),
      eventHandlers: CalendarEventHandlers(
        onEventTapped: _onEventTapped,
        onEventChanged: _onEventChanged,
        onCreateEvent: _onCreateEvent,
        onEventCreated: _onEventCreated,
      ),
    ); 
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const NavBar(),
        drawer: Drawer( //remove/replace soon
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
            ),
        ),
        body: FutureBuilder(
          future: fetchEvents(calendar.eventsController),
          builder: (context, AsyncSnapshot snapshot)
          {
            return snapshot.connectionState == ConnectionState.waiting

                ? CircularProgressIndicator()

                : calendar; 
          }
        )
      ),
    );
  }

  CalendarEvent<Event> _onCreateEvent(DateTimeRange dateTimeRange) {
    String start = getTime(dateTimeRange.start);
    return CalendarEvent(
      dateTimeRange: dateTimeRange,
      eventData: Event(
        title: '$start',
      ),
    );
  }

  Future<void> _onEventCreated(CalendarEvent<Event> event) async {
    String start = getTime(event.dateTimeRange.start);
    String end = getTime(event.dateTimeRange.end);
    String timeRange = "$start - $end";
    event.eventData?.title = timeRange;
    //push to back end; 
    final response = await postEvent(event); 
    if(response.statusCode == 200)
    {
      print("successful post!");
      //place addEvent here when backend works
    }
    // Add the event to the events controller if pushed
    eventController.addEvent(event);

    // Deselect the event.
    eventController.deselectEvent();
  }

  Future<void> _onEventTapped(
    CalendarEvent<Event> event,
  ) async {
    eventController.removeEvent(event);
    if (isMobile) {
      eventController.selectedEvent == event
          ? eventController.deselectEvent()
          : eventController.selectEvent(event);
    }
  }

  Future<void> _onEventChanged(
    DateTimeRange initialDateTimeRange,
    CalendarEvent<Event> event,
    
  ) async {
    String start = getTime(event.dateTimeRange.start);
    String end = getTime(event.dateTimeRange.end);
    String timeRange = "$start - $end";
    event.eventData?.title = timeRange; 
    if (isMobile) {
      eventController.deselectEvent();
    }
  }

  Widget _tileBuilder(
    CalendarEvent<Event> event,
    TileConfiguration configuration,
  ) {
    final color = event.eventData?.color ?? Colors.blue;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      elevation: configuration.tileType == TileType.ghost ? 0 : 8,
      color: configuration.tileType != TileType.ghost
          ? color
          : color.withAlpha(100),
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Text(event.eventData?.title ?? 'New Event')
            : null,
      ),
    );
  }

  Widget _multiDayTileBuilder(
    CalendarEvent<Event> event,
    MultiDayTileConfiguration configuration,
  ) {
    final color = event.eventData?.color ?? Colors.blue;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      elevation: configuration.tileType == TileType.selected ? 8 : 0,
      color: configuration.tileType == TileType.ghost
          ? color.withAlpha(100)
          : color,
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Text(event.eventData?.title ?? 'New Event')
            : null,
      ),
    );
  }

  Widget _scheduleTileBuilder(CalendarEvent<Event> event, DateTime date) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: event.eventData?.color ?? Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(event.eventData?.title ?? 'New Event'),
    );
  }

  Widget _calendarHeader(DateTimeRange dateTimeRange) {
    return Row(
      children: [
        DropdownMenu(
          onSelected: (value) {
            if (value == null) return;
            setState(() {
              currentConfiguration = value;
            });
          },
          initialSelection: currentConfiguration,
          dropdownMenuEntries: viewConfigurations
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
        ),
        IconButton.filledTonal(
          onPressed: controller.animateToPreviousPage,
          icon: const Icon(Icons.navigate_before_rounded),
        ),
        IconButton.filledTonal(
          onPressed: controller.animateToNextPage,
          icon: const Icon(Icons.navigate_next_rounded),
        ),
      ],
    );
  }

  bool get isMobile {
    return kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
  }

  @override
  bool get wantKeepAlive => true;
}

String getTitle(Event? e) {
  String title = e?.title ?? "null";
  return title;
}

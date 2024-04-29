import 'package:friend_me/auth/user.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:friend_me/widgets/schedulefunctions.dart';
import 'package:friend_me/widgets/event.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ScheduleRoute extends StatefulWidget {
  const ScheduleRoute({super.key});

  @override
  State<ScheduleRoute> createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute>
    with AutomaticKeepAliveClientMixin {
  //calendar and events controller
  late String? UID;
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
  void initState() {
    super.initState();
    //DateTime now = DateTime.now();
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
          endDrawer: Drawer(
            //remove/replace soon
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
          // Future builder. waits for connection and Displays calendar on succcessful return from backend, otherwise shows error screen or loading circle appropriately
          //FutureResults holds UID and initial response from http.get.  
          body: FutureBuilder<FutureResults>(
              future: _getResults(calendar.eventsController),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ]));
                } else if (snapshot.data.Response.statusCode != 200) {
                  print("response: ${snapshot.data.Response.statusCode}");
                  print("snapshot: ${snapshot.connectionState}");
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Could not connect to backend!',
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: Text('Retry'))
                      ],
                    ),
                  );
                }
                else if (snapshot.data.UID == null) {
                  print("response: ${snapshot.data.UID}");
                  print("snapshot: ${snapshot.connectionState}");
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'could not retrive Username!',
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: Text('Retry'))
                      ],
                    ),
                  );
                }
                print("response: ${snapshot.data.Response.statusCode}");
                print("snapshot: ${snapshot.connectionState}");
                UID = snapshot.data.UID;
                print("user ID : $UID");              
                return calendar;
              })),
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
    var response = await postEvent(event, UID);
    print("Response status code: ${response.statusCode}");
    if (response.statusCode == 201) {
      print("successful post!");
      eventController.addEvent(event); //only add event to calendar if successfully sent to backend
    }
    else{
      // add pop up dialogue here if event fails to post
    }

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

  // Controls the calendar header.  
  Widget _calendarHeader(DateTimeRange dateTimeRange) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //width constrraints.  will need to fine tune. 
        final buttonWidth = constraints.maxWidth < 600 ? 120.0 : 250.0;
        final viewWidth = constraints.maxWidth < 600 ? 80.0 : 150.0;
        final padding = constraints.maxWidth < 600 ? 0.0 : 4.0;
        final buttonHeight = constraints.maxWidth < 600 ? 40.0 : 48.0;

        final dateFormat = constraints.maxWidth < 600
            ? DateFormat('yyyy - MMM')
            : DateFormat('yyyy - MMMM');

        final dateButton = FilledButton.tonal(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size(buttonWidth, buttonHeight),
            ),
          ),
          onPressed: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: dateTimeRange.start,
              firstDate: DateTime(1970),
              lastDate: DateTime(2040),
            );
            if (selectedDate == null) return;

            controller.animateToDate(
              selectedDate,
            );
          },
          child: Text(
            dateFormat.format(controller.visibleMonth!),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding( //page left button
                padding: EdgeInsets.only(left: padding),
                child: IconButton.filledTonal(
                  onPressed: () {
                    controller.animateToPreviousPage();
                  },
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Previous Page',
                ),
              ),
              dateButton, //year - month and date picker
              Padding( // page right butrton
                padding: EdgeInsets.only(left: padding),
                child: IconButton.filledTonal(
                  onPressed: () {
                    controller.animateToNextPage();
                  },
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'Next Page',
                ),
              ),
              Padding( // move to current date
                padding: EdgeInsets.only(left: padding),
                child: IconButton.filledTonal(
                  onPressed: () {
                    controller.animateToDate(
                      DateTime.now(),
                      duration: const Duration(milliseconds: 800),
                    );
                  },
                  icon: const Icon(Icons.today),
                  tooltip: 'Today',
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(  //drop down menu for month vs week view
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: DropdownMenu(
                        width: viewWidth,
                        onSelected: (value) {
                          if (value == null) return;
                          setState(() {
                            currentConfiguration = value;
                          });
                        },
                        initialSelection: currentConfiguration,
                        dropdownMenuEntries: viewConfigurations
                            .map((e) =>
                                DropdownMenuEntry(value: e, label: e.name))
                            .toList(),
                        inputDecorationTheme: const InputDecorationTheme(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          border: OutlineInputBorder(gapPadding: 16),
                          constraints:
                              BoxConstraints(maxHeight: 42, minHeight: 38),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  bool get isMobile {
    return kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
  }
  //gets values for future builder
  Future<FutureResults> _getResults(CalendarEventsController controller) async {
    final String? _uid = await getUsername(); 
    final http.Response _response = await fetchEvents(controller, _uid);
    return FutureResults(Response: _response, UID : _uid);
  }

  @override
  bool get wantKeepAlive => true;
}

String getTitle(Event? e) {
  String title = e?.title ?? "null";
  return title;
}

//holds values for future builder
class FutureResults{
  final http.Response Response; 
  final String? UID; 
  FutureResults({required this.Response, required this.UID});
}


import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';


class ScheduleRoute extends StatefulWidget {
  const ScheduleRoute({super.key});

  @override
  State<ScheduleRoute> createState() => _ScheduleRouteState();
}

class _ScheduleRouteState extends State<ScheduleRoute> with AutomaticKeepAliveClientMixin{
	//calendar and events controller
	final CalendarController<Event> controller = CalendarController(); 
	final CalendarEventsController<Event> eventController = CalendarEventsController<Event>(); 
	
	//currrent configuration to hold current view and list to hold week and month view. 
	late ViewConfiguration currentConfiguration = viewConfigurations[0]; 
	List<ViewConfiguration> viewConfigurations = [
	WeekConfiguration(),
    MonthConfiguration(),
    //MultiWeekConfiguration( numberOfWeeks: 3, ),
	];
	
	@override
	void initState(){
		super.initState(); 
		DateTime now = DateTime.now();		
	}
	
	@override
	Widget build(BuildContext context){
		final calendar = CalendarView<Event>(
			controller: controller,
			eventsController: eventController,
			viewConfiguration: currentConfiguration,
			tileBuilder: _tileBuilder,
			multiDayTileBuilder: _multiDayTileBuilder,
			scheduleTileBuilder: _scheduleTileBuilder,
			components: CalendarComponents( calendarHeaderBuilder: _calendarHeader, ),
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
				body: calendar,
			),
		);
	}
	CalendarEvent<Event> _onCreateEvent(DateTimeRange dateTimeRange) {
		String start = getTime(dateTimeRange.start); 
		String end = getTime(dateTimeRange.end); 
		String timeRange = "$start - $end";
		return CalendarEvent(
		  dateTimeRange: dateTimeRange,
		  eventData: Event(
			title: '$timeRange',
		  ),
		);
  }

  Future<void> _onEventCreated(CalendarEvent<Event> event) async {
    // Add the event to the events controller.
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
		Column(
			children: <Widget>[
				for(var item in eventController.events) Text(getTitle(item.eventData))
			],
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



//eventDetails
class Event {
  Event({
    required this.title,
    this.description,
    this.color,
  });

  /// The title of the [Event].
  final String title;

  /// The description of the [Event].
  final String? description;

  /// The color of the [Event] tile.
  final Color? color;
}


String getTime(DateTime DT){
	String time = "${DT.hour}:${DT.minute}";
	return time; 
}

String getTitle(Event? e){
	String title = e?.title ?? "null"; 
	return title;
}
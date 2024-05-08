import 'package:flutter/rendering.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:friend_me/widgets/meetup_functions.dart';
import 'package:friend_me/widgets/schedulefunctions.dart';


class HomeRoute extends StatefulWidget {
  HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => HomeRouteState();
}

class HomeRouteState extends State<HomeRoute> {
  bool offline = true;
  late List<MeetUp> meetUps = [];
  String? uid;

  List<String> months = [
    'err',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  // appBar: const NavBar(),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const NavBar(),
        body: FutureBuilder<mFutureResults>(
            future: fetchMeetupsAndUIDdebug(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data?.uid != null &&
                    snapshot.data?.Response.statusCode == 200) {
                  uid = snapshot.data?.uid;
                  if (offline) {
                    print("offline!");
                    meetUps = ListMeetUpsOffline();
                  } else {
                    print("notoffline decodinglist");
                    meetUps = ListMeetUps(snapshot.data!.Response);
                  }
                  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [              Container(
                margin: EdgeInsets.all(30),
                child: Text(
                  'Scheduled Meetups:',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),Expanded(child: ListView.builder(
                    itemCount: meetUps.length,
                    itemBuilder: (context, index) {
                      DateTime start = meetUps[index].start_time;
                      DateTime end = meetUps[index].end_time;
                      return Center(
                          child: SizedBox(
                              width: 500.0,
                              height: 200.0,
                              child: Card(
                                  margin: EdgeInsets.all(10.0),
                                  child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                                '${months[start.month]} ${start.day}'), //replace with string function to show a time range
                                            SizedBox(height: 10),
                                            Text(
                                                '${getTime(start)}-${getTime(end)}'),
                                            SizedBox(height: 10),
                                            Text(
                                                'Meeting with ${meetUps[index].friend_user}'),
                                            SizedBox(height: 10),
                                            ElevatedButton(
                                                onPressed: () => showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                            child: SizedBox(
                                                                width: 500.0,
                                                                height: 200.0,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Text(
                                                                        "future functionality"),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: <Widget>[
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('Accept'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('Decline'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text('Close'),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                )))),
                                                child: const Text("button"))
                                          ])))));
                    },
                  ))] );
                }
              }
              return CircularProgressIndicator();
            }));
  }
}

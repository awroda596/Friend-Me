import 'package:flutter/rendering.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:friend_me/widgets/meetup_functions.dart';
import 'package:friend_me/widgets/schedulefunctions.dart';
import 'package:side_navigation/side_navigation.dart';

class FriendsRoute extends StatefulWidget {
  FriendsRoute({super.key});

  @override
  State<FriendsRoute> createState() => FriendsRouteState();
}

class FriendsRouteState extends State<FriendsRoute> {
  bool offline = true;
  late List<MeetUp> meetUps = [];
  String? uid;
  @override void initState() {
    // TODO: implement initState
    super.initState();

  }
  // appBar: const NavBar(),
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, child: Scaffold(
        appBar: const NavBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: TabBar(
                tabs: [
                  Tab(
                    text: 'Friends',
                  ),
                  Tab(
                    text: 'Pending',
                  ),
                ],
              ),
            ),
            Container(
              height: 80.0,
              child: TabBarView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title:
                           Text('Frank Herbert\n'),
                      trailing: ElevatedButton(onPressed: (){},child: Text("Button"),)
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:  Icon(Icons.person),
                      title: TextField(
                        decoration: const InputDecoration(
                            hintText: 'Search for User...'),
                      ),
                      trailing: IconButton(onPressed: (){}, icon:Icon(Icons.search),),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ))); // Scaffold
  }
}

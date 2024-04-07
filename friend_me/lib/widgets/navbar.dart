import 'package:flutter/material.dart';
import 'package:friend_me/pages/home.dart';
import 'package:friend_me/pages/settings.dart';
import '../pages/schedule.dart'; // Alternate way of things
import 'package:friend_me/pages/profile.dart';

// Class for the nav bar
class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  final textstyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 12);

  @override
  Widget build(BuildContext context) {
    // builds the widget
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 35,
            vertical: preferredSize.height / 10),
        shape: const LinearBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ));
    return AppBar(
        // appbar
        automaticallyImplyLeading: false, // disables big back button appearing
        backgroundColor: Colors.grey, // sets background color
        title: Column(
          // coloum
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // children in the column
            const Text("Friend Me"), // text
            Row(
              // Center the Icons
              crossAxisAlignment: CrossAxisAlignment.start, // Optional
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // sets row of menu items
              children: [
                // children
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Optional
                    mainAxisAlignment: MainAxisAlignment.start,
                    // sets row of menu items
                    children: [
                      // home button
                      OutlinedButton(
                          style: outlineButtonStyle,
                          onPressed: () {
                            Navigator.pop;
                            Navigator.push(
                              // push new page
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeRoute()), // temp until home page is seperate
                            );
                          },
                          child: Text("Home", style: textstyle)),
                      // profile button
                      OutlinedButton(
                          style: outlineButtonStyle,
                          onPressed: () {
                            Navigator.pop; // pops currnet page
                            Navigator.push(
                                // push new page
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                       ProfileRoute(), // temp until home page is seperate
                                ));
                          },
                          child: Text("Profile", style: textstyle)),
                      // schedule button
                      OutlinedButton(
                          style: outlineButtonStyle,
                          onPressed: () {
                            Navigator.pop; // pops currnet page
                            Navigator.push(
                                // push new page
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScheduleRoute(), // temp until home page is seperate
                                ));
                          },
                          child: Text("Schedule", style: textstyle)),
                      // Friends button
                      OutlinedButton(
                          style: outlineButtonStyle,
                          onPressed: () {},
                          child: Text("Friends", style: textstyle)),
                      // Settings button
                      OutlinedButton(
                          style: outlineButtonStyle,
                          onPressed: () {Navigator.pop; // pops currnet page
                            Navigator.push(
                                // push new page
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SettingsRoute(), // temp until home page is seperate
                                ));
                          },
                          child: Text("Settings", style: textstyle)),
                    ]),
              ],
            )
          ],
        ));
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // neccessary to return appbar
}

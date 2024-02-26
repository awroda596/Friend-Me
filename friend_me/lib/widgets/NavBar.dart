import 'package:flutter/material.dart';
import 'package:friend_me/main.dart';
import 'package:friend_me/pages/profile.dart';

// Class for the nav bar
class NavBar extends StatelessWidget{
    const NavBar({super.key});
    @override
    Widget build(BuildContext context){ // builds the widget
        return Drawer( // drawer
            child:ListView( // list view of the sidbar
                padding: EdgeInsets.zero, // padding 
                children: <Widget> [ // children with takes all items on nav bar
                   const DrawerHeader(  // drawer header
                        decoration: BoxDecoration( // decoration
                        color: Colors.grey), // makes color of decoration box grey
                         child: Text(  // child of decoration with text
                            'Menu', // menu string
                            style: TextStyle(color:Colors.white,fontSize:25), // styles the text given color and fontsize
                        ),
                    ),  
                    ListTile(  // home listview on nav bar
                        title: const Text('Home'), // text of title of item on nav bar
                         onTap: (){ // on tap
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.push( // push 
                            context, // context
                            MaterialPageRoute(builder: (context) => const MyApp()), // push profileroute page
                          );
                        }
                    ),   
                    ListTile( // list tile for profile
                        title: const Text('Profile'), // text of title of item on nav bar
                        onTap: (){ // on tap
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.push( // push 
                            context, // context
                            MaterialPageRoute(builder: (context) => const ProfileRoute()), // push profileroute page
                          );
                        }
                    ),     
                    ListTile(
                        title: const Text('Schedule'), // text of title of item on nav bar
                        onTap: () => {Navigator.of(context).pop()}, // on tap, use navigation pop // nothing for now
                    ),   
                    ListTile(
                        title: const Text('Friends'), // text of title of item on nav bar
                        onTap: () => {Navigator.of(context).pop()}, // on tap, use navigation pop // nothing for now
                    ), 
                       ListTile(
                        title: const Text('Settings'), // text of title of item on nav bar
                        onTap: () => {Navigator.of(context).pop()}, // on tap, use navigation pop // nothing for now
                    ),  
            ]
        ));
    }   
}

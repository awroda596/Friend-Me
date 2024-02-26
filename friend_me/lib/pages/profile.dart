import 'package:flutter/material.dart';
import 'package:friend_me/widgets/NavBar.dart';

class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

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
      body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                    "Profile Name Temp name",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: const DecorationImage(
                    image: AssetImage('images/Profile_template.png'), // stock image
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.width/4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  image:  DecorationImage(
                     image: AssetImage('images/Profile.png'), // stock image
                    fit: BoxFit.cover,
                  ),
                ),),
                IconButton(onPressed: settings, icon: const Icon(Icons.settings, color: Colors.white)) // placeholder
                  ]
                ),
              )
        ]
      )
    );
  }
}
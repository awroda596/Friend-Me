import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:friend_me/widgets/profile_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRoute extends StatefulWidget {
   const ProfileRoute({super.key});
   @override
    State<ProfileRoute> createState() => Profile();
}


class Profile extends State<ProfileRoute>{
  Profile();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> ?profileBio;
  Future<String> ?privateName;
  Future<String> ?publicName;
  

  late bool _background = false;
  late bool _profile = false;

  Uint8List _webProfileImage = Uint8List(8);
  Uint8List _webBackgroundImage = Uint8List(8);



   Future<void> _getPics() async {
      String profilePic = await  _prefs.then((SharedPreferences prefs){
      return (prefs.getString('profilePic') ?? 'NULL');
    });
    String backgroundPic = await  _prefs.then((SharedPreferences prefs){
      return (prefs.getString('backgroundImage') ?? 'NULL');
    });
    if (profilePic == 'NULL'){
      _profile = false;
    }
    else{
      _profile = true;
      _webProfileImage = base64Decode(profilePic);
    }
   if (backgroundPic == 'NULL'){
      _background = false;
    }
    else{
      _background = true;
      _webBackgroundImage = base64Decode(backgroundPic);
    }

  }

    @override
  void initState() {
    super.initState();
    profileBio = _prefs.then((SharedPreferences prefs){
      return prefs.getString('profileBio') ?? "This is where your Bio will go";
    });
    privateName = _prefs.then((SharedPreferences prefs){
      return prefs.getString('privateName') ?? "John Doe";
    });
    publicName = _prefs.then((SharedPreferences prefs){
      return prefs.getString('publicName') ?? "John Doe";
    });

  
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const NavBar(),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<void>(
                future: _getPics(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } 
                      else {
                        return   Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 6,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image:  DecorationImage(
                              image: _background == true? 
                                Image.memory(_webBackgroundImage).image // if true , do this
                                : const AssetImage( // else do this
                                  'images/Profile_template.png'), // stock image
                                  fit: BoxFit.fill,
                            ),
                            border: Border.all(
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row (mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width / 6,
                                      height: MediaQuery.of(context).size.height / 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child:  Container(    // else not true do this container
                                        width: MediaQuery.of(context).size.width / 4,
                                        height: MediaQuery.of(context).size.height / 6,
                                        decoration:  BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image:  _profile ?
                                              Image.memory(_webProfileImage).image
                                              :const AssetImage(
                                                'images/Profile.png'), // stock image
                                                fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                     )
                                    ),
                                ]),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop; // pops currnet page
                                    Navigator.push(
                                  // push new page
                                      context,
                                     MaterialPageRoute(
                                       builder: (context) =>
                                          const ProfileSettingRoute(), // temp until home page is seperate
                                      )
                                    );
                                  },
                                  icon: const Icon(Icons.settings,
                                    color: Colors.white)
                                ) // placeholder
                            ]
                          ),
                        )
                      );
                    }  // else case
                  }   // switch in builder
                } 
              ),
                FutureBuilder<String>(
                  future: publicName,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}',
                          );
                        }
                   }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     FutureBuilder<String>(
                      future: privateName,
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                              '${snapshot.data}',
                              );
                            }
                        }
                    }),
                    const Text(
                      "About Me",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 4,
                      child: FutureBuilder<String>(
                        future: profileBio,
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const CircularProgressIndicator();
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Text(
                                '${snapshot.data}',
                                );
                              }
                          }
                      }),
                    )
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 4,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text("Most Met Friends"),
                            Container(
                              width: MediaQuery.of(context).size.width / 16,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/Profile.png'), // stock image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 16,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/Profile.png'), // stock image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 16,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/Profile.png'), // stock image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ]),
                    ))
              ],
            ),
            const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "This is for the schedule, To be worked on.",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ])
          ],
        )));
  }
}

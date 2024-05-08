import 'package:flutter/material.dart';
import 'package:friend_me/picture.dart';
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
  Picture getPicture = Picture();

  final _publicNameStyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 35  
  );  

  
  final _privateNameStyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 25  
  );  

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<void>(
                future: getPicture.getPics(),
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
                              image: getPicture.checkBackground() == true? 
                                Image.memory(getPicture.getProfileBackground()).image // if true , do this
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
                                            image:  getPicture.checkPhoto() ?
                                              Image.memory(getPicture.getProfilePhoto()).image
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/10,
                      height: MediaQuery.of(context).size.height / 8,
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
                                '${snapshot.data}', style: _publicNameStyle
                            );
                          }
                        }
                      }
                    )
                ]
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Container(
                    width: MediaQuery.of(context).size.width / 20,
                    height: 0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              '${snapshot.data}', style: _privateNameStyle
                              );
                            }
                        }
                    }),
                    Container(
                      width: 0,
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                    const Text( /////////////////////////////////////
                      "About Me",
                      style: TextStyle(fontSize: 25, color: Colors.black),
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
                /*Container(
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
                    )) */
              ],
            ),
            /*const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "This is for the schedule, To be worked on.",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ])*/
          ],
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:friend_me/widgets/profile_setting.dart';

class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const NavBar(),
      body: SingleChildScrollView(
      child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/6,
                  decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: const DecorationImage(
                    image: AssetImage('images/Profile_template.png'), // stock image
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
                    Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  image:  DecorationImage(
                     image: AssetImage('images/Profile.png'), // stock image
                    fit: BoxFit.scaleDown,
                  ),
                ),),
                IconButton(
                  onPressed:  (){
                      Navigator.pop; // pops currnet page
                      Navigator.push( // push new page
                        context,
                        MaterialPageRoute(builder: (context) =>  ProfileSettingRoute(), // temp until home page is seperate
                      ));
                    },  
                  icon: const Icon(Icons.settings, color: Colors.white)) // placeholder
                  ]
                ),
                )),
               const Text(
                    "John Doe",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       const Text(
                        "Private Name",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                const Text(
                        "About Me",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/4,
                child: const Text(
                    "This is to be about me, Test text to make sure container is good to go. ",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                  )],   
                ),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/4,
                child:  SingleChildScrollView (
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Most Met Friends"
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/16,
                        height: MediaQuery.of(context).size.height/16,
                        decoration: const  BoxDecoration(
                          shape: BoxShape.circle,
                            image:  DecorationImage(
                            image: AssetImage('images/Profile.png'), // stock image
                          fit: BoxFit.cover,
                        ),
                    ),),
                    Container(
                        width: MediaQuery.of(context).size.width/16,
                        height: MediaQuery.of(context).size.height/16,
                        decoration: const  BoxDecoration(
                          shape: BoxShape.circle,
                            image:  DecorationImage(
                            image: AssetImage('images/Profile.png'), // stock image
                          fit: BoxFit.cover,
                        ),
                    ),),
                    Container(
                        width: MediaQuery.of(context).size.width/16,
                        height: MediaQuery.of(context).size.height/16,
                        decoration: const  BoxDecoration(
                          shape: BoxShape.circle,
                            image:  DecorationImage(
                            image: AssetImage('images/Profile.png'), // stock image
                          fit: BoxFit.cover,
                        ),
                    ),),
                       
                    ]
                ),
               ))],
        ),
        const Column(
           mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "This is for the schedule, To be worked on.",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),

              ]

        )
        ],
       
      ))
    );
  }
}
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friend_me/pages/profile.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCreationRoute extends StatefulWidget {
  const ProfileCreationRoute({super.key});
  @override
  State<ProfileCreationRoute> createState() => ProfileCreation();
}

class ProfileCreation extends State<ProfileCreationRoute> {
  ProfileCreation();
  late bool _background = false;
  late bool _profile = false;

  late int textSize;

  Uint8List _webProfileImage = Uint8List(8);
  Uint8List _webBackgroundImage = Uint8List(8);
  
  final TextEditingController _privateName = TextEditingController();
  final TextEditingController _publicName = TextEditingController();
  final TextEditingController _profileBio = TextEditingController();


  final textstyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 15    
  );
  final aboutTextStyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 12
  );
  final privateNameStyle = const TextStyle(     
      // defines text style
      color: Colors.black,
      fontSize: 30
  );


final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> ?profileBio;
  Future<String> ?privateName;
  Future<String> ?publicName;


  @override
  void initState() {
    super.initState();
    
  }

  Future<void> _getPrivateName() async {
    _privateName.text = await  _prefs.then((SharedPreferences prefs){
      return prefs.getString('privateName') ?? "";
    });
  }


  Future<void> _getPublicName() async {
    _publicName.text = await  _prefs.then((SharedPreferences prefs){
      return prefs.getString('publicName') ?? "";
    });
  }

  Future<void> _getProfileBio() async {
    _profileBio.text = await  _prefs.then((SharedPreferences prefs){
      return prefs.getString('profileBio') ?? "";
    });
  }

  // future function to get the pics in shared prefs if it exists, future to update page if pics exist
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


  Future<void> _getPhoto() async{
    if(kIsWeb){
      final SharedPreferences prefs = await _prefs;
      bool success = false;
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null){
        var web = await image.readAsBytes();
        String base64Image = base64Encode(web);
        success = await prefs.setString("profilePic", base64Image);
        if (!success){
            if (kDebugMode) {
              print("profile Pic not saved");
            }
        }
        save();
        setState(() {
        });
      }
      else {
        if (kDebugMode) {
          print("No image was selected");
        }
      }
    }
  }


// note that background and profile pic is being saved automatically
    Future<void>  _getBackground() async{
     if(kIsWeb){
      final SharedPreferences prefs = await _prefs;
      bool success = false;
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null){
        var web = await image.readAsBytes();
        String base64Image = base64Encode(web);
        success = await prefs.setString("backgroundImage", base64Image);
        if (!success){
            if (kDebugMode) {
              print("profile Pic not saved");
            }
        }
        setState(() {
        });
      }
      else {
        if (kDebugMode) {
          print("No image was selected");
        }
      }
    }

  }


 void save() async{
    // Saves items in shared prefs as of right now, everything should be saved to backend
    final SharedPreferences prefs = await _prefs;
    bool success = false;
    success = await prefs.setString("profileBio", _profileBio.text);
    if (!success){
       if (kDebugMode) {
         print("profile bio not saved");
       }
    }
    success = await prefs.setString("publicName", _publicName.text);
    if (!success){
      if (kDebugMode) {
        print("Public name not saved");
      }
    }
    success = await prefs.setString("privateName", _privateName.text);
    if (!success){
      if (kDebugMode) {
        print("Private name not saved");
      }
    }
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Welcome to Friend Me!", style: TextStyle(fontSize: 30)),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Profile Creation", style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox( // padding
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.height /20,
              ),
               SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height/10,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                    child:
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Select Public Name: ", style: textstyle),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 10,
                      child:  FutureBuilder<void>(
                          future: _getPublicName(),
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
                                    return TextFormField(
                                      controller: _publicName,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        focusColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Public Display Name"
                                      )
                                    );
                                  }
                              }
                          }),
                    ),
                ]))),
                SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height/10,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                    child:
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     
                    Text("Select Private Name: ", style: textstyle),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 10,
                      child:  FutureBuilder<void>(
                          future: _getPrivateName(),
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
                                    return TextFormField(
                                      controller: _privateName,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        focusColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Private Display Name"
                                      )
                                    );
                                  }
                              }
                          }),
                    ),
                  ]))),
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
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 6,
                                      height: MediaQuery.of(context).size.height / 7,
                                      child:  Row( 
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Profile Photo: ", style: textstyle),
                                      ],)  
                                    ),
                        IconButton(
                           onPressed: _getPhoto,
                             icon: const Icon(Icons.add_a_photo,
                              color: Colors.cyan)),
                              Container( // else not true do this container
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 8,
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
                              ),
                              
                          ]),  // row end
                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.height / 7,
                                child:  Row( 
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Background Photo: ", style: textstyle),
                                  ],
                                )  
                              ),
                              IconButton(
                                onPressed: _getBackground,
                                  icon: const Icon(Icons.wallpaper,
                                  color: Colors.cyan)),
                             
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 7,
                                child: Row (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 20,
                                      height: MediaQuery.of(context).size.height /20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 5,
                                      height: MediaQuery.of(context).size.height / 5,
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
                                   ),)
                                ],
                               ) ,                             
                              ),
                            ]
                          ),  
                        ],
                      );
              }}}),
              Row(                                                             
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "About Me",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 5,
                            child: FutureBuilder<void>(
                          future: _getProfileBio(),
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
                                    return TextFormField(
                                      maxLines: 30,
                                      maxLength: 400,
                                      style: aboutTextStyle,
                                      controller: _profileBio,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        focusColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(),
                                        hintText:"Enter general information about yourself that you would like to share with others."
                                      )
                                    );
                                  }
                              }
                          }),            
                          )
                        ])
                  ]),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 8,
                        height: MediaQuery.of(context).size.height / 20,
                        child: FloatingActionButton(
                          heroTag: "Create Profile",
                          onPressed: () {
                            save();
                            Navigator.pop(context);
                            Navigator.push(
                                // push new page
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                     ProfileRoute(), // temp until home page is seperate
                                ));
                          },
                          backgroundColor: Colors.green,
                          child: const Text('Create Profile',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),  
     ));
  }
}
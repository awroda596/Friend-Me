import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friend_me/pages/profile.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingRoute extends StatefulWidget {
  const ProfileSettingRoute({super.key});
  @override
  State<ProfileSettingRoute> createState() => ProfileSetting();
}

class ProfileSetting extends State<ProfileSettingRoute> {
  ProfileSetting();
  late bool _background = false;
  late bool _profile = false;

  Uint8List _webProfileImage = Uint8List(8);
  Uint8List _webBackgroundImage = Uint8List(8);

  final TextEditingController _publicName = TextEditingController();
  final TextEditingController _profileBio = TextEditingController();


  final textstyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 24    
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
    privateName = _prefs.then((SharedPreferences prefs){  // might change to its own function to better understand
      return prefs.getString('privateName') ?? "John Doe";
    });
  }

  Future<void> _getPublicName() async {
    _publicName.text = await  _prefs.then((SharedPreferences prefs){
      return prefs.getString('publicName') ?? "John Doe";
    });
  }

  Future<void> _getProfileBio() async {
    _profileBio.text = await  _prefs.then((SharedPreferences prefs){
      return prefs.getString('profileBio') ?? "This is where your Bio will go";
    });
  }

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
    // Does nothing right now placeholder
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
  }

  // Reference https://api.flutter.dev/flutter/widgets/PopScope-class.html
  void _showBackDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page? All progress will be lost.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const NavBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            image: _profile ?
                                              Image.memory(_webProfileImage).image
                                              :const AssetImage(
                                                'images/Profile.png'), // stock image
                                                fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                     )
                                    ),
                                    IconButton(
                                      onPressed: _getPhoto,
                                      icon: const Icon(Icons.add_a_photo,
                                      color: Colors.white)),
                               ]),
                              IconButton(
                                onPressed: _getBackground,
                                icon: const Icon(Icons.edit,
                                color: Colors.white)
                              ),
                            ]
                          ),
                        )
                      );
                    }  // else case
                  }   // switch in builder
                } 
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Public Display Name: ", style: textstyle),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 6,
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
                  ]),
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
                            style: privateNameStyle,
                          );
                        }
                   }
                }),
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
                            height: MediaQuery.of(context).size.height / 4,
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
                          child: PopScope(
                            canPop: false,
                            onPopInvoked: (bool pop) {
                              if (pop) return;
                              _showBackDialog(context);
                            },
                            child: FloatingActionButton(
                              heroTag: "cancel",
                              onPressed: () {
                                _showBackDialog(context);
                              },
                              backgroundColor: Colors.red,
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 8,
                        height: MediaQuery.of(context).size.height / 20,
                        child: FloatingActionButton(
                          heroTag: "save",
                          onPressed: () {
                            save();
                            Navigator.pop(context);
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
                          child: const Text('Save',
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

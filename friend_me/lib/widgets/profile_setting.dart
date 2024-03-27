import 'package:flutter/material.dart';
import 'package:friend_me/widgets/navbar.dart';

class ProfileSettingRoute extends StatefulWidget {
  const ProfileSettingRoute({super.key});
  @override
  State<ProfileSettingRoute> createState() => ProfileSetting();
}

class ProfileSetting extends State<ProfileSettingRoute> {
  ProfileSetting();
  final TextEditingController _publicName = TextEditingController();
  final textstyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 24);
  final aboutTextStyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 12);

  @override
  void initState() {
    super.initState();
  }

  settings() {
    // Does nothing right now placeholder
  }

  save() {
    // Does nothing right now placeholder
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
    _publicName.text = "John Doe";
    return Scaffold(
        appBar: const NavBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: const DecorationImage(
                      image: AssetImage(
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
                          Container(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.height / 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/Profile.png'), // stock image
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: settings,
                                        icon: const Icon(Icons.add_a_photo,
                                            color: Colors.white)) // placeholder
                                  ])),
                          IconButton(
                              onPressed: settings,
                              icon: const Icon(Icons.edit,
                                  color: Colors.white)) // placeholder
                        ]),
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Public Display Name: ", style: textstyle),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 6,
                      child: TextFormField(
                          controller: _publicName,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              hintText: "Enter Public Display Name")),
                    ),
                  ]),
              const Text(
                "Private Name",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
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
                            child: TextFormField(
                                maxLines: 30,
                                maxLength: 400,
                                style: aboutTextStyle,
                                controller: _publicName,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    hintText:
                                        "Enter general information about yourself that you would like to share with others.")),
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

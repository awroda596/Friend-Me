import 'package:flutter/material.dart';
import 'package:friend_me/widgets/navbar.dart';

class RegisterRoute extends StatefulWidget {
  const RegisterRoute({super.key});
  @override
  State<RegisterRoute> createState() => Register();
}

class Register extends State<RegisterRoute> {
   Register();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final textstyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 18);

    @override
  void initState() {
    super.initState();
  }

  void _showProgressIndicator(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // makes it so it can't be dismissed
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
          )
        );
      },
    );
  }

  void _showErrorIndicator(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return  Center(
            child: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 6,
            child: const DefaultTextStyle(
              style: TextStyle(
                // defines text style
                color: Color.fromARGB(255, 179, 64, 64),
                fontSize: 18,
                backgroundColor: Colors.grey,
                ),
              child: Text("Make sure you fill out all fields")
            ) 
          )
        );
      },
    );
  }

  void _register(BuildContext context) {
    _showProgressIndicator(context);
    if (_firstName.text == "" || _lastName.text == "" || _username.text == "" || _password.text == "" || _email.text == ""){
        Navigator.pop(context);
        _showErrorIndicator(context);
        return;
    }
    // do the HTTP request
  }




  
   




/*
  FutureBuilder<String>(
  future: lazyValue,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!);
    } else {
      return const CircularProgressIndicator();
    }
  },
),

*/

  @override
  Widget build(BuildContext context) {
    _firstName.text = "";
    _lastName.text = "";
    _username.text = "";
    _password.text = "";
    _email.text = "";
     return Scaffold(
      appBar: const NavBar(),
      body: Center(
        widthFactor: MediaQuery.of(context).size.width / 4,
        heightFactor: MediaQuery.of(context).size.height/4,
        child: Column(
          // coloum
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                  width: MediaQuery.of(context).size.width/1.6,
                  height: MediaQuery.of(context).size.height/1.7,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 165, 220, 246),
                    border: Border.all(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height/2,
                      ),
                      child:Column(
          // coloum
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Register", style: TextStyle(
                          // defines text style
                            color: Colors.black,
                            fontSize: 24),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                          // Center the Icons
                              crossAxisAlignment: CrossAxisAlignment.center, // Optional
                              mainAxisAlignment: MainAxisAlignment.spaceAround, 
                          // sets row of menu items
                              children: [
                                Text("First Name: ", style: textstyle),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: MediaQuery.of(context).size.height / 15,
                                  child: TextFormField(
                                    controller: _firstName,
                                    style: const TextStyle(fontSize: 13),
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter first Name")
                                  ),
                                ),
                              ]
                            )),
                              SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                          // Center the Icons
                              crossAxisAlignment: CrossAxisAlignment.start, // Optional
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          // sets row of menu items
                              children: [
                                Text("Last Name: ", style: textstyle),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: MediaQuery.of(context).size.height / 15,
                                  child: TextFormField(
                                    controller: _lastName,
                                    style: const TextStyle(fontSize: 13),
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Last Name")
                                  ),
                                ),
                              ]
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                          // Center the Icons
                              crossAxisAlignment: CrossAxisAlignment.start, // Optional
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          // sets row of menu items
                              children: [
                                Text("       Email: ", style: textstyle),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: MediaQuery.of(context).size.height / 15,
                                  child: TextFormField(
                                    controller: _email,
                                    style: const TextStyle(fontSize: 13),
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter email")
                                  ),
                                ),
                              ]
                            ),
                          ),
                           SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                          // Center the Icons
                              crossAxisAlignment: CrossAxisAlignment.start, // Optional
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          // sets row of menu items
                              children: [
                                Text("Username: ", style: textstyle),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: MediaQuery.of(context).size.height / 15,
                                  child: TextFormField(
                                    controller: _username,
                                    style: const TextStyle(fontSize: 13),
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter username")
                                  ),
                                ),
                              ]
                            ),
                          ),
                           SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                          // Center the Icons
                              crossAxisAlignment: CrossAxisAlignment.start, // Optional
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                          // sets row of menu items
                              children: [
                                Text("Password: ", style: textstyle),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: MediaQuery.of(context).size.height / 15,
                                  child: TextFormField(
                                    obscuringCharacter : '*',
                                    obscureText: true,
                                    controller: _password,
                                    style: const TextStyle(fontSize: 13),
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter password")
                                  ),
                                ),
                              ]
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width/2,
                              ),
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.end, // Optional
                                mainAxisAlignment: MainAxisAlignment.end, 
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 8,
                                    height: MediaQuery.of(context).size.height / 18,
                                    child: FloatingActionButton(
                                      heroTag: "register",
                                      onPressed: () {
                                        _register(context);
                            

                                      },
                                      backgroundColor: Colors.green,
                                      child: const Text('Register',
                                        style: TextStyle(color: Colors.white)),
                                      ),
                                  )
                                ],
                              ),
                      
                            ),
                          ),
                        ]
                    ),      
                 )      
              )
            ),
          ]
        ),
      )
     );
  }
}
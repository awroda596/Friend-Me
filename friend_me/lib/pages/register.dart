import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friend_me/pages/home.dart';
import 'package:friend_me/widgets/backend/backend.dart';
import 'package:friend_me/widgets/backend/user.dart';
import 'package:friend_me/widgets/navbar.dart';



class RegisterRoute extends StatefulWidget {
  const RegisterRoute({super.key});
  @override
  State<RegisterRoute> createState() => Register();
}

class Register extends State<RegisterRoute> {
   Register();
   // text Controlers
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

   late String errorMessage = ''; // error message

  final textstyle = const TextStyle(
      // defines text style
      color: Colors.black,
      fontSize: 18);

    @override
  void initState() {
    super.initState();
    // initializes controler text
    _firstName.text = "";
    _lastName.text = "";
    _username.text = "";
    _password.text = "";
    _email.text = "";
  }

  void refreshWidget(){ // refreshes the widget tree in case of changes
    setState(() {
    
    });
  }

  void _showProgressIndicator(BuildContext context) { /// shows a progress indicator center of screen
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


  Future<void> _register(BuildContext context) async{
     _showProgressIndicator(context);
    if (_firstName.text == "" || _lastName.text == "" || _username.text == "" || _password.text == "" || _email.text == ""){
         Navigator.pop(context);
        errorMessage = "Fill out all Fields";
        refreshWidget(); // refresh
        return;
    }
    User user  = User(  // unsure if User is needed considering backend, might git rid of
      username: _username.text, 
      email: _email.text, 
      firstName: _firstName.text, 
      lastName: _lastName.text, 
      password: _password.text
    );
    Backend backend = Backend();
    var response = await backend.register(user); // register
    if (!context.mounted) {
      if (kDebugMode) {
        print("not Mounted");
      }
      return;
    }
    if (response.statusCode != 200){ // if error, print error
       Navigator.pop(context);
       errorMessage = response.body;
       refreshWidget(); // refresh
      return;
    }
    user.auth = response.body;   // unsure if this will be used
    user.password = ''; // unsure
    Navigator.pop(context); // pop progress indicator
    Navigator.pop(context); // pop page
    Navigator.push( // push homepage
      context,
      MaterialPageRoute(
        builder: (context) =>
        const HomeRoute()), 
      );
  }


  @override
  Widget build(BuildContext context) {
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
                          Text(
                            errorMessage, style: const TextStyle(
                          // defines text style
                            color: Colors.red,
                            fontSize: 13),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround, 
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
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
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
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
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
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
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                                children: [
                                  SizedBox(  // button that goes to home page
                                    width: MediaQuery.of(context).size.width / 8,
                                    height: MediaQuery.of(context).size.height / 18,
                                    child: FloatingActionButton(
                                      heroTag: "Cancel",
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const HomeRoute()), // temp until home page is seperate
                                        );
                                      },
                                      backgroundColor: Colors.red,
                                      child: const Text('Cancel',
                                        style: TextStyle(color: Colors.white)),
                                      ),
                                  ),
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
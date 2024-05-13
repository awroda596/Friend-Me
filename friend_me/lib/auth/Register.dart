import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:friend_me/pages/profileCreation.dart';
import 'package:friend_me/widgets/register_functions.dart';

Future<String?> tryRegister(String mail, String pass) async {
  print('$mail');
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: mail,
      password: pass,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    print(e);
  }
  print('success');
  return "success!";
}

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => RegisterState();
}

//replace with streambuilder method in login
class RegisterState extends State<Register> {
  RegisterState();
  String? uc = "";
  final TextEditingController _publicName = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _email.addListener(() {
      final String email = _email.text;
      _email.value = _email.value.copyWith(
        text: email,
        selection:
            TextSelection(baseOffset: email.length, extentOffset: email.length),
        composing: TextRange.empty,
      );
    });
    _password.addListener(() {
      final String pass = _password.text;
      _password.value = _password.value.copyWith(
        text: pass,
        selection:
            TextSelection(baseOffset: pass.length, extentOffset: pass.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? uid = FirebaseAuth.instance.currentUser?.uid;
            if (uid == null) {
              print("uid null");
            }
            friendme_user newUser = friendme_user(
                id: 0,
                uid: uid,
                username: _publicName.text,
                email: _email.text,
                first_name: _firstName.text,
                last_name: _lastName.text);
            postUser(newUser, uid);
            return ProfileCreationRoute();
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(30),
                child: Text(
                  'Register an Account',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                    minHeight: 200,
                    minWidth: 400,
                    maxHeight: 600,
                    maxWidth: 500),
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _publicName,
                          decoration:
                              InputDecoration(labelText: 'Public Username'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _firstName,
                          decoration: InputDecoration(labelText: 'First Name'),
                        ),
                        TextField(
                          controller: _lastName,
                          decoration: InputDecoration(labelText: 'Last Name'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _email,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _password,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_publicName.text.isEmpty) {
                              setState(() {
                                uc = "Please enter a public username!";
                              });
                            } else if (_firstName.text.isEmpty) {
                              setState(() {
                                uc = "Please enter your first name!";
                              });
                            } else if (_lastName.text.isEmpty) {
                              setState(() {
                                uc = "Please enter your last name!";
                              });
                            } else if (_email.text.isEmpty) {
                              setState(() {
                                uc = "Please enter an email!";
                              });
                            } else if (_password.text.isEmpty) {
                              setState(() {
                                uc = "Please enter a password!";
                              });
                            } else {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: _email.text,
                                  password: _password.text,
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  setState(() {
                                    uc = 'The password provided is too weak.';
                                  });
                                } else if (e.code == 'email-already-in-use') {
                                  setState(() {
                                    uc =
                                        'The account already exists for that email.';
                                  });
                                }
                              } catch (e) {
                                setState(() {
                                  uc = '$e';
                                });
                              }
                            }
                          },
                          child: Text(
                            'Register',
                          ),
                        ),
                        Text(
                          '$uc',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Already registered?',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextButton(
                          child: Text('Sign in!'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ]),
              ),
            ],
          ));
        });
  }
}

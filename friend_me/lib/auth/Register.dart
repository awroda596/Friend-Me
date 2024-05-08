import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => RegisterState();
}

//replace with streambuilder method in login
class RegisterState extends State<Register> {
  RegisterState();
  final TextEditingController _publicName = TextEditingController();
  final TextEditingController _privateName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
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
                          decoration: InputDecoration(labelText: 'Public Name'),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _privateName,
                          decoration:
                              InputDecoration(labelText: 'Private Name'),
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
                          onPressed: () {
                            var cred = FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _email.text,
                                    password: _password.text);
                            if (cred != null) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Register'),
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

import 'package:flutter/material.dart';
import 'package:friend_me/auth/Login.dart';
<<<<<<< Updated upstream
import 'package:friend_me/auth/landing_page.dart';
import 'landing_page.dart';
=======
>>>>>>> Stashed changes
import 'auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< Updated upstream
      home: const Login(),
=======
      home: Login(),
>>>>>>> Stashed changes
    );
  }
}

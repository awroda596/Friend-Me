import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});
 // appBar: const NavBar(),
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}

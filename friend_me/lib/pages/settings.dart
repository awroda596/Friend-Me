import 'package:friend_me/auth/app.dart';
import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

void _signOutC(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Pop the current page
    Navigator.pop(context);
    // Push the new page (HomeRoute in this case)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}

class SettingsRoute extends StatelessWidget {
  const SettingsRoute({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Settings!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ElevatedButton(
              onPressed: () => _signOutC(context),
              child: const Text('Logout'),
            ),
            // const SignOutButton(),
          ],
        ),
      ),
    );
  }
}

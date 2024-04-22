import 'package:friend_me/widgets/navbar.dart';
import 'package:flutter/material.dart';
// Returns username
import 'package:friend_me/auth/user.dart';

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
            FutureBuilder<String?>(
              future: getUsername(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Display a loading indicator while waiting for the result
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Display an error message if there's an error
                } else {
                  final username = snapshot.data;
                  return Text(
                    'Username: ${username ?? "Not logged in"}',
                    style: TextStyle(fontSize: 18),
                  ); // Display the username if available, otherwise display a default message
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

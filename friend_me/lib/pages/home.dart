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
      /*
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('../assets/images/Profile.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      */
      
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
           //  const SignOutButton(),
          ],
        ),
      ),
    );
  }
}

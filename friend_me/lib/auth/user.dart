// Putting user collection in main
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getUsername() async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      // Return the user's unique identifier (UID)
      return user.uid;
    } else {
      // Return null if the user is not signed in
      return '';
    }
  } catch (e) {
    // Handle any errors
    print('Error fetching username: $e');
    return '';
  }
}

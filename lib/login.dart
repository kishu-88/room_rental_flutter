import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the Google Sign-In flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the authentication details from the Google user
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the obtained authentication details
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the credential
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // Return the user credential
      return userCredential;
    }

    return null; // Return null if the Google Sign-In process was canceled
  }

  void signIn() async {
    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential != null) {
      // Signed in successfully, handle the user data
      User user = userCredential.user!;
      // Perform further operations with the signed-in user
    } else {
      // Google Sign-In was canceled
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: signIn,
        child: Text('Sign in with Google'),
      ),
    );
  }
}

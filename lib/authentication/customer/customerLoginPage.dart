import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../customer/home.dart';

class RoomCustomerLoginPage extends StatefulWidget {
  const RoomCustomerLoginPage({super.key});

  @override
  State<RoomCustomerLoginPage> createState() => _RoomCustomerLoginPageState();
}

class _RoomCustomerLoginPageState extends State<RoomCustomerLoginPage> {
  static Future<User?> roomCustomerLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
      }
    }

    return user;
  }

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

  // Retrieve the stored email value from shared preferences
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // Store the email value in shared preferences
  Future<void> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController roomCustomerEmailController =
        TextEditingController();
    final TextEditingController roomCustomerPasswordController =
        TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 100),
          width: 1000, // Specify the desired width of the rectangle
          height: 600, // Specify the desired height of the rectangle
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20),
          //   color: const Color.fromARGB(255, 27, 91, 118),
          // ),
          alignment: Alignment.center,

          child: Column(
            children: [
              Container(
                // margin: const EdgeInsets.all(55),
                padding: const EdgeInsets.all(5),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "Login As Room Customer",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: roomCustomerEmailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: roomCustomerPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () async {
                        User? user = await roomCustomerLogin(
                            email: roomCustomerEmailController.text,
                            password: roomCustomerPasswordController.text,
                            context: context);
                        // print("user");
                        if (user != null) {
                          String email =
                              roomCustomerEmailController.text.trim();

                          // Store the email value in shared preferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString('email', email);

                          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomerHomePage(),
                  ),
                );
                          print("done");
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Login Failed'),
                                content: Text(
                                    'No user found with these credentials.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.yellow),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          // Set the desired color of the rectangle
        ),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
      ),
    );
  }
}

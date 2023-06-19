import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_rental/authentication/roomOwner/roomOwnerLoginPage.dart';
// import 'package:room_rental/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RoomOwner/home.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  static Future<User?> RoomOwnerLogin(
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

  void signIn() async {
    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential != null) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomePage()),
      // );
      // User user = userCredential.user!;
      // Perform further operations with the signed-in user
    } else {
      // Google Sign-In was canceled
    }
  }

  @override
  Widget build(BuildContext context) {
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
              ClipRRect(
                // borderRadius: BorderRadius.circular(100),
                child: Image.asset('images/logo_trans.png',
                    height: 200, width: 200),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 100),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                          Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const RoomOwnerLoginPage()));
                      // showModalBottomSheet(
                      //   context: context,
                      //   shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.vertical(
                      //     top: Radius.circular(30),
                      //   )),
                      //   builder: (context) => roomOwnerLoginSheet(context),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                    child: const Text(
                      'Room Owner',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  )),
              Container(
                  // margin: const EdgeInsets.all(55),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        )),
                        builder: (context) => customerLoginSheet(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                    child: const Text(
                      'Customer',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  )),
            ],
          ),
          // Set the desired color of the rectangle
        ),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
      ),
    );
  }

  Widget roomOwnerLoginSheet(BuildContext context) {
    final TextEditingController roomOwnerEmailController =
        TextEditingController();
    final TextEditingController roomOwnerPasswordController =
        TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Container(
      height: MediaQuery.of(context).size.height * 1,
      decoration: const BoxDecoration(
        color: Color(0xFF1B5B76),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            "Login As Room Owner",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextFormField(
            controller: roomOwnerEmailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.0),
              ),
              // labelText: 'Email',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextFormField(
            controller: roomOwnerPasswordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.0),
              ),
              // labelText: 'Password',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 15),
          child: ElevatedButton(
            onPressed: () async {
              User? user = await RoomOwnerLogin(
                  // email: roomOwnerEmailController.text,
                  email: "karan@karan.com",
                  password: "karan123",
                  context: context);
              // print("user");
              if (user != null) {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                String email = roomOwnerEmailController.text;
                prefs.setString('email', email);

                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const HomePage()));
                print("done");
              } else {
                print("no user foud with these credentials.");
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ElevatedButton(
          onPressed: signIn,
          child: Text('Sign in with Google'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              )),
              builder: (context) => roomOwnerSignUpSheet(context),
            );
          },
          child: const Text(
            'Not Registered Yet?',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }

  Widget customerLoginSheet(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Color(0xFF1B5B76),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Login As Customer",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
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
                onPressed: () {
                  // Navigate to the new page/screen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomePage(),
                  //   ),
                  // );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.yellow),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  )),
                  builder: (context) => customerSignUpSheet(context),
                );
              },
              child: const Text(
                'Not Registered Yet?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );

  Widget roomOwnerSignUpSheet(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 6,
        decoration: const BoxDecoration(
          color: Color(0xFF1B5B76),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              "Sign Up As Room Owner",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
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
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                ),
                labelText: 'Phone',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                ),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                ),
                labelText: 'Confirm Password',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the new page/screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomePage(),
                //   ),
                // );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ]),
      );

  Widget customerSignUpSheet(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 6,
        decoration: const BoxDecoration(
          color: Color(0xFF1B5B76),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              "Sign Up As Customer",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
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
            child: TextField(
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
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                ),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(90.0),
                ),
                labelText: 'Confirm Password',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the new page/screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomePage(),
                //   ),
                // );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ]),
      );
}

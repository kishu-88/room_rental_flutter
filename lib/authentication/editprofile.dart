import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../customer/customerHome.dart';
import '../../customer/customerProfile.dart';
import './register.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String email = '';
  var sexOption;
  var martialStatusOption;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    getEmail().then((value) {
      setState(() {
        email = value ?? '';
      });
    });
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<User?> editProfilePage({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController roomCustomerEmailController =
        TextEditingController();
    final TextEditingController roomCustomerPasswordController =
        TextEditingController();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const CustomerProfilePage()));
            },
          ),
          title: const Text('Edit Details'),
          backgroundColor: const Color.fromARGB(255, 27, 91, 118),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.1,
              horizontal: screenWidth * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0),
                TextFormField(
                  controller: roomCustomerEmailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: roomCustomerEmailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Username',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: roomCustomerEmailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Age',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: const Text(
                      'Sex : ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: sexOption,
                      onChanged: (String? value) {
                        setState(() {
                          sexOption = value;
                        });
                      },
                    ),
                    const Text(
                      'Male',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: 'Female',
                      groupValue: sexOption,
                      onChanged: (String? value) {
                        setState(() {
                          sexOption = value;
                        });
                      },
                    ),
                    const Text(
                      'Female',
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio<String>(
                      value: 'Others',
                      groupValue: sexOption,
                      onChanged: (String? value) {
                        setState(() {
                          sexOption = value;
                        });
                      },
                    ),
                    const Text(
                      'Others',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: const Text(
                      'Martial Status : ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Single',
                      groupValue: martialStatusOption,
                      onChanged: (String? value) {
                        setState(() {
                          martialStatusOption = value;
                        });
                      },
                    ),
                    const Text(
                      'Single',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: 'Married',
                      groupValue: sexOption,
                      onChanged: (String? value) {
                        setState(() {
                          sexOption = value;
                        });
                      },
                    ),
                    const Text(
                      'Married',
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio<String>(
                      value: 'Others',
                      groupValue: sexOption,
                      onChanged: (String? value) {
                        setState(() {
                          sexOption = value;
                        });
                      },
                    ),
                    const Text(
                      'Others',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    'Select Date of Birth',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: roomCustomerPasswordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Religion',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: roomCustomerPasswordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Occupation',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () async {
                    User? user = await editProfilePage(
                      email: roomCustomerEmailController.text,
                      password: roomCustomerPasswordController.text,
                      context: context,
                    );
                    if (user != null) {
                      String email = roomCustomerEmailController.text.trim();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('email', email);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const CustomerHomePage(),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Login Failed'),
                            content:
                                Text('No user found with these credentials.'),
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
      ),
    );
  }
}

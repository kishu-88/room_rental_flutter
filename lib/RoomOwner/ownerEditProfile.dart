import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../RoomOwner/ownerHome.dart';
import '../RoomOwner/ownerProfile.dart';
import 'package:image_picker/image_picker.dart';

class EditOwnerProfilePage extends StatefulWidget {
  const EditOwnerProfilePage({Key? key}) : super(key: key);

  @override
  State<EditOwnerProfilePage> createState() => _EditOwnerProfilePageState();
}

class _EditOwnerProfilePageState extends State<EditOwnerProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  final uploadedImageUrl = '';

  final picker = ImagePicker();

  String email = '';
  var sexOption;
  var martialStatusOption;
  DateTime? selectedDate;

    var id = DateTime.now().millisecondsSinceEpoch;


  Future<String> uploadUserImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      try {
        // Upload the image to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child('userImages/$id.jpg');
        final uploadTask = storageRef.putFile(file);
        await uploadTask;

        // Get the image download URL
        final downloadUrl = await storageRef.getDownloadURL();

        final uploadedImageUrl = downloadUrl;

        // Store the image URL in Firebase Cloud Firestore
        final firestoreInstance = FirebaseFirestore.instance;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .update(
          {
            'imageUrl':downloadUrl,
          },
        );
        return downloadUrl; // Return the download URL as a String
      } catch (e) {
        throw Exception(
            'Image upload failed.'); // Throw an exception if there's an error
      }
    }
    throw Exception('Image upload failed.'); // Throw an exception if there's an error
  }

  onUploadComplete(String downloadUrl) {
    // Use the downloadUrl as needed
    String uploadedImageUrl = downloadUrl;
    // print('Image download URL: $uploadedImageUrl');
    return uploadedImageUrl;
  }

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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          title: const Text('Complete Profile Setup'),
          backgroundColor: const Color.fromARGB(255, 27, 91, 118),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.05,
              horizontal: screenWidth * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0),
                TextFormField(
                  enabled: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: "Edit Profile Picture",
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                 Container(
                      width: double.infinity,
                      child: Row(
                        // Use Row to place the label and upload button in the same line
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  String uploadedImageUrl = await uploadUserImage();
                                  // Use the download URL as needed
                                  print(
                                      'Image uploaded. URL: $uploadedImageUrl');
                                } catch (e) {
                                  // Handle any errors
                                  print('Error uploading image: $e');
                                }
                              },
                              child: const Text("Upload Image"),
                            ),
                          ),
                        ],
                      ),
                    ),
                SizedBox(height: screenHeight * 0),
                TextFormField(
                  enabled: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: "E-Mail : $email",
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: usernameController,
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
                  controller: fullnameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Fullname',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: phoneController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Phone',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: ageController,
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
                    const SizedBox(width: 10),
                    Radio<String>(
                      value: 'Married',
                      groupValue: martialStatusOption,
                      onChanged: (String? value) {
                        setState(() {
                          martialStatusOption = value;
                        });
                      },
                    ),
                    const Text(
                      'Married',
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio<String>(
                      value: 'Others',
                      groupValue: martialStatusOption,
                      onChanged: (String? value) {
                        setState(() {
                          martialStatusOption = value;
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
                SizedBox(height: 20),
                Text(
                  selectedDate == null
                      ? 'No Date Selected'
                      : 'Selected Date of Birth: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: religionController,
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
                  controller: occupationController,
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
                  onPressed: () {
                    submitForm(context);
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

  void submitForm(BuildContext context) async {
    print("clicked");
    final String username = usernameController.text;
    final String fullname = fullnameController.text;
    final String phone = phoneController.text;
    final String age = ageController.text;
    final String religion = religionController.text;
    final String occupation = occupationController.text;
    final String sex = sexOption;
    final String martialStatus = martialStatusOption;

    // Perform form validation here if needed before saving to the database

    // try {
    //   final QuerySnapshot usernameSnapshot = await FirebaseFirestore.instance
    //       .collection('users')
    //       .where('username', isEqualTo: username)
    //       .get();

      // if (usernameSnapshot.docs.isNotEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content: Text(
      //             'Username already exists. Please choose a different one.')),
      //   );
      //   return;
      // }

      // Check if the phone number already exists in any document in the 'users' collection
      // final QuerySnapshot phoneSnapshot = await FirebaseFirestore.instance
      //     .collection('users')
      //     .where('phone', isEqualTo: phone)
      //     .get();

      // if (phoneSnapshot.docs.isNotEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content: Text(
      //             'Phone number already exists. Please use a different one.')),
      //   );
      //   return;
      // }

      // If both username and phone number are unique, proceed to save the form data to Firebase Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'email': email, // Assuming email is defined somewhere in your code.
        'username': username,
        'fullname': fullname,
        'phone': phone,
        'age': age,
        'religion': religion,
        'occupation': occupation,
        'sex': sex,
        'maritalStatus': martialStatus,
        // Add more fields as needed
      });
      print("nice");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OwnerHomePage()),
      );
      // Clear the form after successful submission
      usernameController.clear();
      phoneController.clear();
      ageController.clear();
      religionController.clear();
      occupationController.clear();
    } 
    // catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         content: Text('Failed to submit form. Please try again later.')),
    //   );
    // }
  }

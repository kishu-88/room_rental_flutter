import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/components/white_rounded_textfield.dart';
import '../ownerHome.dart';

class AddFlatsPage extends StatefulWidget {
  const AddFlatsPage({super.key});

  @override
  State<AddFlatsPage> createState() => _AddFlatsPageState();
}

class _AddFlatsPageState extends State<AddFlatsPage> {
  int _activeStepIndex = 0;
  final areaController = TextEditingController();
  final floorController = TextEditingController();
  final sizeController = TextEditingController();
  final landmarkController = TextEditingController();
  // final downloadUrl = '';

  final uploadedImageUrl = '';

  final picker = ImagePicker();

  bool isChecked = false;

  var parkingOption;

  var fencingAvailability;

  get downloadUrl => null;

  Future<String> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      try {
        // Upload the image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = storageRef.putFile(file);
        await uploadTask;

        // Get the image download URL
        final downloadUrl = await storageRef.getDownloadURL();

        final uploadedImageUrl = downloadUrl;

        // Store the image URL in Firebase Cloud Firestore
        final firestoreInstance = FirebaseFirestore.instance;
        await firestoreInstance
            .collection('images')
            .add({'imageUrl': downloadUrl});

        return downloadUrl; // Return the download URL as a String
      } catch (e) {
        throw Exception(
            'Image upload failed.'); // Throw an exception if there's an error
      }
    }

    throw Exception(
        'Image upload failed.'); // Throw an exception if there's an error
  }

  onUploadComplete(String downloadUrl) {
    // Use the downloadUrl as needed
    String uploadedImageUrl = downloadUrl;
    print('Image download URL: $uploadedImageUrl');
    return uploadedImageUrl;
  }

  bool agreeToTerms = false;

  String dropdownvalue = 'Choose Your Preference';

  String email = '';

  @override
  void initState() {
    super.initState();
    getEmail().then((value) {
      setState(() {
        email = value ?? '';
      });
    });
  }

  //getting email from shared preference
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // List of preferences items in our dropdown menu
  var items = [
    'Choose Your Preference',
    'Family',
    'Student',
    'Business Person'
  ];

  get onStepCancel => null;
  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Details'),
          content: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text(
                            "Building Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child:
                              WhiteRoundedTextfield(controller: areaController),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text(
                            "Flat Size",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: WhiteRoundedTextfield(
                                controller: sizeController)),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: const Text(
                            "Floor",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: WhiteRoundedTextfield(
                              controller: floorController),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Fencing Availability',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Available',
                                  groupValue: fencingAvailability,
                                  onChanged: (String? value) {
                                    setState(() {
                                      fencingAvailability = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Available',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 20),
                                Radio<String>(
                                  value: 'Not Available',
                                  groupValue: fencingAvailability,
                                  onChanged: (String? value) {
                                    setState(() {
                                      fencingAvailability = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Not Available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: const Text(
                            "Nearest Landmark",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: WhiteRoundedTextfield(
                                controller: landmarkController)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  child: DropdownButton(
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Car Parking',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Available',
                                  groupValue: parkingOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      parkingOption = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Available',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 20),
                                Radio<String>(
                                  value: 'Not Available',
                                  groupValue: parkingOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      parkingOption = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Not Available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Photo'),
            content: Container(
              width: double.infinity,
              child: Column(children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String uploadedImageUrl = await uploadImage();
                      // Use the download URL as needed
                      print('Image uploaded. URL: $uploadedImageUrl');
                    } catch (e) {
                      // Handle any errors
                      print('Error uploading image: $e');
                    }
                  },
                  child: const Text("Upload Image"),
                ),
              ]),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content:
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (bool? value) {
                  setState(() {
                    agreeToTerms = value ?? false;
                  });
                },
              ),
              const Text(
                'I agree to the terms and conditions',
                style: TextStyle(fontSize: 20.0),
              ),
            ])),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: const Color(0xFFFFFFFF), child: const Text("Add Flat")),
      ),
      body: Stepper(
          type: StepperType.horizontal,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (_activeStepIndex < (stepList().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              Map<String, dynamic> data = {
                "user": email,
                "Location": areaController.text,
                "Size": sizeController.text,
                "Floor": floorController.text,
                "Nearest Landmark": landmarkController.text,
                "Preference": dropdownvalue,
                "Parking": parkingOption,
                "imageUrl": uploadedImageUrl,
              };
              FirebaseFirestore.instance
                  .collection("Rooms")
                  .doc()
                  .set(data)
                  .then((_) {
                // Navigation logic to another page on success
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OwnerHomePage()),
                );
              });
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }
            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          }),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

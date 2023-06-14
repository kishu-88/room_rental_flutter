import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_rental/home.dart';

class AddRoomsPage extends StatefulWidget {
  const AddRoomsPage({super.key});

  @override
  State<AddRoomsPage> createState() => _AddRoomsPageState();
}

class _AddRoomsPageState extends State<AddRoomsPage> {
  int _activeStepIndex = 0;
  final areaController = TextEditingController();
  final floorController = TextEditingController();
  final sizeController = TextEditingController();
  final landmarkController = TextEditingController();
  TextEditingController pincode = TextEditingController();

     bool agreeToTerms = false;


  // Initial Selected Value
  String preferenceDropdownvalue = 'Choose Your Preference';

  String locationDropdownvalue = 'Choose Your Location';

  String roomNumberDropdownvalue = 'No. of rooms';

  // List of preferences items in our dropdown menu
  var preferenceItems = [
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
                            "Room Area (Location)",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextField(
                            controller: areaController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              // hoverColor: Colors.amber,
                              // filled: true,
                              // fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
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
                            "Room Size",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextField(
                            controller: sizeController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              // hoverColor: Colors.amber,
                              // filled: true,
                              // fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                        ),
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
                          child: TextField(
                            controller: floorController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              // hoverColor: Colors.amber,
                              // filled: true,
                              // fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                        ),
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
                          child: TextField(
                            controller: landmarkController,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              // hoverColor: Colors.amber,
                              // filled: true,
                              // fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  // decoration: const BoxDecoration(
                  //   color: Colors.amber,),
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
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
              child: Column(
                children: const [Text("page 1")],
              ),
            )),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Confirm'),
          content:  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ]
        )
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: const Color(0xFFFFFFFF), child: const Text("hi")),
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
                    "Location": areaController.text,
                    "Size": sizeController.text,
                    "Floor": floorController.text,
                    "Preference": dropdownvalue
                  };
                  FirebaseFirestore.instance
                      .collection("Rooms")
                      .doc("Room4")
                      .set(data)
                      .then((_) {
                    // Navigation logic to another page on success
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
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

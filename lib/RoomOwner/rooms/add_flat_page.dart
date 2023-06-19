import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_rental/RoomOwner/home.dart';
import 'package:image_picker/image_picker.dart';

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

  final picker = ImagePicker();

  selectFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  }

  bool agreeToTerms = false;

  String dropdownvalue = 'Choose Your Preference';

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
                            "Flat Area (Location)",
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
                            "Flat Description",
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
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  child: DropdownButton(
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
                              color: Color.fromARGB(255, 13, 79, 71)),
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
                    onPressed: selectFile, child: const Text("Upload Image"))
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
                "Location": areaController.text,
                "Size": sizeController.text,
                "Floor": floorController.text,
                "Nearest Landmark": landmarkController.text,
                "Preference": dropdownvalue
              };
              FirebaseFirestore.instance
                  .collection("Flats")
                  .doc("flat1")
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bookingRequestNotiPage extends StatefulWidget {
  const bookingRequestNotiPage({super.key});

  @override
  State<bookingRequestNotiPage> createState() => _bookingRequestNotiPageState();
}

class _bookingRequestNotiPageState extends State<bookingRequestNotiPage> {
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

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Requests"),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
      ),
      body: Container(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          decoration: const BoxDecoration(
            color: Color(0xFF2284AE),
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Booking Requests').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                  final containsSearchString = documents.any((doc) {
                    final data = doc.data()
                        as Map<String, dynamic>?; // Explicit type cast
                    final fieldValue =
                        data?["Owner"]; // Explicit type cast
                    var searchString = email;

                    return fieldValue != null &&
                        fieldValue.contains(searchString);
                  });

                  if (containsSearchString) {
                    return Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 27, 91, 118),
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  child: const Icon(
                                    Icons.location_city_outlined,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: const Text(
                                    "You have a booking request",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return const Text("hi");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

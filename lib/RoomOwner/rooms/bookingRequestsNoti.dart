// ignore_for_file: avoid_print

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
            stream: FirebaseFirestore.instance
                .collection('Booking Requests')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var requester; // Declare the 'requester' variable outside the loop
                var roomId; // Declare the 'requester' variable outside the loop

                final documents = snapshot.data!.docs;
                final containsSearchString = documents.any((doc) {
                  final data =
                      doc.data() as Map<String, dynamic>?; // Explicit type cast
                  final ownerName = data?["Owner"];
                  requester = data?["Requester"];
                  roomId = data?["RoomId"]; // Explicit type cast
                  var searchString = email;

                   return ownerName != null &&
            ownerName.contains(searchString) && requester != null;
                });

                if (containsSearchString) {
                  print(requester);
                  print(roomId);
                  return Column(
                    children: [
                       ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child:  Text(
                                    "You have a booking request from $requester",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                      "You have not added any room requests!",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_rental/RoomOwner/rooms/bookingRequestPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customerRoomDetailsPage.dart';

class customerBookingRequestsNoti extends StatefulWidget {
  const customerBookingRequestsNoti({super.key});

  @override
  State<customerBookingRequestsNoti> createState() => _customerBookingRequestsNotiState();
}

class _customerBookingRequestsNotiState extends State<customerBookingRequestsNoti> {
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
                final documents = snapshot.data!.docs;
                final ownerDocuments = documents.where((doc) {
                  final data =
                      doc.data() as Map<String, dynamic>?; // Explicit type cast
                  final requesterEmail = data?["Requester"];
                  final roomStatus = data?["Status"];
                  var searchString = email;
                  const status = "Open";
                  return requesterEmail != null && requesterEmail
                  .contains(searchString) && roomStatus.contains(status);
                }).toList();

                if (ownerDocuments.isNotEmpty) {
                  return Column(
                    children: ownerDocuments.map((doc) {
                      final data = doc.data()
                          as Map<String, dynamic>?; // Explicit type cast
                      final owner = data?["Owner"];
                      final documentId = doc.id;
                      final roomId = data?["RoomId"];
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                   CustomerRoomDetails(documentId:roomId),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "You have requested to book a room from $owner",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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

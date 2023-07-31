// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_rental/customer/customerCurrentRent.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                .collection('Rents')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final documents = snapshot.data!.docs;
                final ownerDocuments = documents.where((doc) {
                  final data =
                      doc.data() as Map<String, dynamic>?; // Explicit type cast
                  final renterEmail = data?["Renter"];
                  final rentStatus = data?["Status"];
                  var searchString = email;
                  return renterEmail != null && renterEmail
                  .contains(searchString) &&  rentStatus=="Active";;
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
                                   CustomerRentDetailsPage(documentId:documentId,roomId:roomId),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "$owner have accepted room booking request.",
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
                    child: Column(
                      children: [
                         Icon(
                          Icons.mood_bad_outlined,
                          color: Colors.red,
                          size: 100
                        ),
                        SizedBox(
                            width:
                               50), 
                        Text(
                          "Nothing Here!!",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
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

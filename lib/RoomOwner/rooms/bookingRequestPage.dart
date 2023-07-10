import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'customerDetailView.dart';
class BookingRequestPage extends StatefulWidget {
  final String documentId;

  BookingRequestPage({required this.documentId});

  @override
  _BookingRequestPageState createState() => _BookingRequestPageState();
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  @override
  Map<String, dynamic>? documentData;
  Map<String, dynamic>? roomData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Booking Requests') // Replace with your collection name
          .doc(widget.documentId)
          .get();

      if (snapshot.exists) {
        setState(() {
          documentData = snapshot.data();
        });

        var roomId = documentData!['RoomId'];
        var requesterEmail = documentData!['Requseter'];

        DocumentSnapshot<Map<String, dynamic>> roomSnapshot =
            await FirebaseFirestore.instance
                .collection('Rooms')
                .doc(roomId)
                .get();

        if (roomSnapshot.exists) {
          setState(() {
            roomData = roomSnapshot.data();
          });
        } else {
          print('Error fetching room:');
        }
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Request Page'),
      ),
      body: Column(
        children: [
          Center(
            child: roomData != null
                ? Image.network(
                    roomData!['imageUrl'],
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )
                : const CircularProgressIndicator(),
          ),
          roomData != null
              ? Container(
                  child: Text(
                    'Floor: ${roomData!['Floor']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              : const CircularProgressIndicator(),
          roomData != null
              ? Container(
                  child: Text(
                    'Location: ${roomData!['Location']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              : const Text("room Data is null"),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 190, 147, 145),
            ),
            child: Column(
              children: [
                documentData != null
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Booking Request from ${documentData!['Requester']}',
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      )
                    : const Text("Not Found"),
                documentData != null
                    ? ElevatedButton(
                        onPressed: () {
                          var requesterEmail = documentData!['Requester'];
                             Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerDetailView(requester: requesterEmail,)),
                      );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              'View Profile',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    : const Text("Not Found")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            height: 30,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const LoginOptions()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'Accept',
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const LoginOptions()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'Deny',
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

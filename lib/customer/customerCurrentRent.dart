import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:room_rental/customer/customerProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRentDetailsPage extends StatefulWidget {

    final String documentId;
  final String roomId;

  CustomerRentDetailsPage({
    required this.documentId,
    required this.roomId,
  });

  @override
  _CustomerRentDetailsPageState createState() => _CustomerRentDetailsPageState();
}

class _CustomerRentDetailsPageState extends State<CustomerRentDetailsPage> {
  Map<String, dynamic>? data;
  Map<String, dynamic>? rentdata;
  bool isLoading = true;

  @override
  bool isFavorite = false;
  String email = '';

  @override
  void initState() {
    super.initState();
     fetchDocumentData();
    getEmail().then((value) {
      setState(() {
        email = value ?? '';
      });
    });
  }

  void freeRoom(String roomId,documentId) {
  print(roomId);
  // Reference to the document in the 'Rooms' collection with the provided roomId
  DocumentReference roomRef = FirebaseFirestore.instance.collection('Rooms').doc(roomId);
  DocumentReference rentRef = FirebaseFirestore.instance.collection('Rents').doc(documentId);

              // Get the current date and time
          DateTime now = DateTime.now();
 

  // Get the month name from the DateTime object
  String monthName = DateFormat('MMMM').format(now);

  // Merge day and month name as a string
  String dateMonthString = "${now.day} $monthName";
  
  // Update the 'status' field to 'open'
  roomRef.update({'Status': 'Open','Renter':''});
  rentRef.update({'Status': 'InActive','Released At':dateMonthString});
    print('Room status updated successfully to "open" for roomId: $roomId');
  }

  Future<void> fetchDocumentData() async {
    try {
        print(widget.documentId);

      // Get a reference to the Firestore document using the provided ID
      DocumentReference<Map<String, dynamic>> roomsdocumentRef =

          FirebaseFirestore.instance.collection('Rooms').doc(widget.roomId);

      DocumentSnapshot<Map<String, dynamic>> roomSnapshot = await roomsdocumentRef.get();

       DocumentReference<Map<String, dynamic>> rentdocumentRef =
          FirebaseFirestore.instance.collection('Rents').doc(widget.documentId);

      DocumentSnapshot<Map<String, dynamic>> rentSnapshot = await rentdocumentRef.get();

      if (rentSnapshot.exists) {
              // Document data is available
              setState(() {
                rentdata = rentSnapshot.data();
                        // isLoading = false;
              });
            } else {
              // Document doesn't exist
              print("rent document doesn't exist");
              setState(() {
                                  // isLoading = false;
              });
            }

      if (roomSnapshot.exists) {
        // Document data is available
        setState(() {
          data = roomSnapshot.data();
          // rentdata = rentSnapshot.data();
                  isLoading = false;

        });
      } else {
        // Document doesn't exist
        print("room document doesn't exist");
        setState(() {
          data = null;
                  isLoading = false;

        });
      }

    } catch (e) {
      print('Error fetching document from Firestore: $e');
      setState(() {
        // data = null;
        isLoading = false;
      });
    }
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> addInfoToFirestore(
      String user, String email, String roomId) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Booking Requests');

      // Create a new document with a unique ID
      DocumentReference<Map<String, dynamic>> documentRef = collection.doc();
      DateTime now = DateTime.now();
      // Set the data to be added
      await documentRef.set({
        'RoomId': roomId,
        'Requester': email,
        'Owner': user,
        'Status': "Open",
        'Created At:':now,

      });

      // Now, update the 'Status' field in the 'rooms' collection
    CollectionReference<Map<String, dynamic>> roomsCollection =
        FirebaseFirestore.instance.collection('Rooms');

    // Get a reference to the specific room document based on the 'roomId'
    DocumentReference<Map<String, dynamic>> roomDocRef =
        roomsCollection.doc(roomId);

    // Update the 'Status' field to "Open" in the room document
    await roomDocRef.set({'Status': 'Open'}, SetOptions(merge: true));

    print('Status field added to the room document successfully!');

      print('Information added to Firestore successfully!');
    } catch (e) {
      print('Error adding information to Firestore: $e');
    }
  }

  Future<void> removeDocumentFromFirestore(String roomId) async {
    print(roomId);
    try {
    // Get a reference to the Firestore collection
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('Booking Requests');

    // Query the collection based on the conditions (Requester = email and RoomId = roomId)
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collection
        .where('Requester', isEqualTo: email)
        .where('RoomId', isEqualTo: roomId)
        .get();

    if (querySnapshot.size > 0) {
      // Since you mentioned that there might be only one matching document, use the first one
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          querySnapshot.docs.first;
      DocumentReference<Map<String, dynamic>> documentRef =
          collection.doc(documentSnapshot.id);

      // Delete the document
      await documentRef.delete();

      print('Document removed from Firestore successfully!');
    } else {
      print('No matching document found in Firestore.');
    }
  } catch (e) {
    print('Error removing document from Firestore: $e');
  }
  }

  

  @override
  Widget build(BuildContext context) {
      if (isLoading) {
      // You can show a loading indicator while data is being fetched
      return Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: const CircularProgressIndicator(),
      );
    } else if (data != null && rentdata != null)  {
      final imageUrl = data!['imageUrl'];
      final location = data!['Location'];
      final rate = data!['Rate'];
      final owner = data!['Owner'];
      final roomId = data!['id'];

      final startedAt = rentdata!['Start Date'];

      // Continue building your UI using the fetched data
      // ...


    // Use the document data to display room details
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: Colors.white,
            ),
            onPressed: () {
              // setState(() {
              //   isFavorite = !isFavorite;
              // });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.yellow,
              ),
              child: const Text(
                "Details",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: DataTable(
                columns: <DataColumn>[
                const DataColumn(label: Text('Rate',style: TextStyle(fontSize: 20,color: Colors.white),)),
                DataColumn(label: Text('Rs '+ rate,style: const TextStyle(fontSize: 20,color: Colors.white),)),
              ],  
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text(
                        "Location : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        location,
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Owner : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        owner,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                   DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Started At : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        startedAt,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue),
                    child: const Row(
                      children: [
                         Icon(Icons.phone,
                        color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                         Text(
                          'Call',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () { freeRoom(roomId.toString(),widget.documentId);},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                    child: Row(
                      children: [
                          Icon(Icons.login,
                        color: Colors.black,
                          ),
                         Text(
                          '  Free Rent',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Add more room details as needed
          ],
        ),
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }else{
    return const Text("no data found");
  }
}
}
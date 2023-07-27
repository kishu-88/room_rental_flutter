import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_rental/customer/customerProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRoomDetails extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> document;

  const CustomerRoomDetails({required this.document});
  final String fieldName = "your_field_name";

  @override
  _CustomerRoomDetailsState createState() => _CustomerRoomDetailsState();
}

class _CustomerRoomDetailsState extends State<CustomerRoomDetails> {
  @override
  bool isFavorite = false;
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

  Future<void> removeDocumentFromFirestore(String documentId) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Booking Requests');

      // Get a reference to the document using the provided ID
      DocumentReference<Map<String, dynamic>> documentRef =
          collection.doc(documentId);

      // Delete the document
      await documentRef.delete();

      print('Document removed from Firestore successfully!');
    } catch (e) {
      print('Error removing document from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.document.data() as Map<String, dynamic>?;
    final imageUrl = data?['imageUrl'];
    final location = data?['Location'];
    final floor = data?['Floor'];
    final landmark = data?['Nearest Landmark'];
    final parking = data?['Parking'];
    final negotiability = data?['Negotiability'];
    final preference = data?['Preference'];
    final rate = data?['Rate'];
    final size = data?['Size'];
    final owner = data?['Owner'];
    final roomId = data?['id'];

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
                columns: const <DataColumn>[
                  DataColumn(label: SizedBox.shrink()),
                  DataColumn(label: SizedBox.shrink()),
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
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Floor : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        floor,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Size : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        size,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Nearest Landmark : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        landmark,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Parking : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        parking,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Preference : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        preference,
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
                        "Rate : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        rate,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Is Rate Negotiable : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        negotiability,
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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Booking Requests")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error: Unable to retrieve data');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      final docs = snapshot.data!.docs;
                      final containsSearchString = docs.any((doc) {
                        final data = doc.data()
                            as Map<String, dynamic>?; // Explicit type cast
                        String documentId = doc.id;
                        print(documentId);

                        final id = data?["RoomId"]; // Explicit type cast
                        final requester =
                            data?["Requester"]; // Explicit type cast
                        final owner = data?["Owner"]; // Explicit type cast
                        var searchString = email;

                        return id != null &&
                            id.contains(roomId.toString()) &&
                            searchString.contains(requester);
                      });

                      if (containsSearchString) {
                        return ElevatedButton(
                          onPressed: () {
                            var documentId;
                            removeDocumentFromFirestore(documentId.toString());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: const Text(
                            'Requested',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            addInfoToFirestore(owner, email, roomId.toString());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: const Text(
                            'Request',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                    child: const Text(
                      'Call',
                      style: TextStyle(fontSize: 20, color: Colors.black),
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
  }
}

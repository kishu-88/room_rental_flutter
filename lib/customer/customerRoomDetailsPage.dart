import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_rental/customer/customerProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRoomDetails extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> document;

  const CustomerRoomDetails({required this.document});

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

  Future<void> addInfoToFirestore(String user, String email, String roomId) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('Booking Requests');

    // Create a new document with a unique ID
    DocumentReference<Map<String, dynamic>> documentRef =
        collection.doc(roomId);

    // Set the data to be added
    await documentRef.set({
      'RoomId':roomId,
      'Requester': user,
      'Owner':email,
      'Status':"Open",
    });

    print('Information added to Firestore successfully!');
  } catch (e) {
    print('Error adding information to Firestore: $e');
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
            final user = data?['user'];
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
                        user,
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
                  child: ElevatedButton(
                    onPressed: () {
                    addInfoToFirestore(user,email,roomId.toString());

                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                    child: const Text(
                      'Request',
                      style: TextStyle(fontSize: 35, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                    child: const Text(
                      'Call',
                      style: TextStyle(fontSize: 35, color: Colors.black),
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

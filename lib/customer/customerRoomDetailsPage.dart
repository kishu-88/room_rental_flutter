import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_rental/RoomOwner/ownerProfile.dart';
import 'package:room_rental/customer/customerProfile.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerRoomDetails extends StatelessWidget {
  bool isFavorite = false;

  final QueryDocumentSnapshot document;

  CustomerRoomDetails(this.document, {super.key});

  @override
  Widget build(BuildContext context) {
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
              document['imageUrl'],
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
                        document['Location'],
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
                        document['Floor'],
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(
                        "Area : ",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                      DataCell(Text(
                        document['Size'],
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
                        document['Nearest Landmark'],
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
                        document['Parking'],
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
                        document['Preference'],
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
                        document['user'],
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
                        document['Rate'],
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
                        document['Negotiability'],
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const CustomerProfilePage()));
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

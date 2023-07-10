import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerDetailView extends StatefulWidget {
  final String requester;

  CustomerDetailView({required this.requester});

  @override
  _CustomerDetailViewState createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends State<CustomerDetailView> {
  String customerName = '';
  String customerEmail = '';
  // Add more variables for other customer information

  @override
  void initState() {
    super.initState();
    fetchCustomerInfo();
  }

  void fetchCustomerInfo() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.requester)
          .get();

      if (snapshot.exists) {
        // Retrieve customer information from the document
        setState(() {
          customerName = snapshot['name'];
          customerEmail = snapshot['email'];
          // Set other customer information variables here
        });
      }
    } catch (error) {
      print('Error fetching customer info: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Detail"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(24),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(255, 27, 91, 118),
              ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'images/profile_pic.jpg',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Text(widget.requester,style: TextStyle(fontSize: 20,color: Colors.white),),
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
                        "location",
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
                        "floor",
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
                        "size",
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
                        "landmark",
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
                        "parking",
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
                        "preference",
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
                        "owner",
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
                        "rate",
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
                        "negotiability",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

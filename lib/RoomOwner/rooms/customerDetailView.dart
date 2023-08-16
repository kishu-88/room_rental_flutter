import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerDetailView extends StatefulWidget {
  final String requester;

  CustomerDetailView({required this.requester});

  @override
  _CustomerDetailViewState createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends State<CustomerDetailView> {
  String fullname = '';
  String email = '';
  String username = '';
  String age = '';
  String sex = '';
  String religion=  '';
  String occupation = '';
  String maritalStatus = '';
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
          fullname = snapshot['fullname'];
          email = snapshot['email'];
          username = snapshot['username'];
          age = snapshot['age'];
          sex = snapshot['sex'];
          religion = snapshot['religion'];
          maritalStatus = snapshot['maritalStatus'];
          occupation = snapshot['occupation'];
          // Set other customer information variables here
        });
      }
    } catch (error) {
      // print('Error fetching customer info: $error');
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
              margin: const EdgeInsets.all(12),
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
            Text(widget.requester,style: const TextStyle(fontSize: 25,color: Colors.white),),
           Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: SizedBox.shrink()),
                  DataColumn(label: SizedBox.shrink()),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text(
                        "Fullname : ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                      DataCell(Text(
                        fullname,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text(
                        "Username : ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                      DataCell(Text(
                      username.isEmpty ? 'Loading...' : username,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text(
                        "Age : ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                      DataCell(Text(
                        age,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text(
                        "Sex : ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                      DataCell(Text(
                        sex,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                     const DataCell(Text(
                        "Marital Status : ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                      DataCell(Text(
                        maritalStatus,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text(
                        "Occupation : ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                      DataCell(Text(
                        occupation,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
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

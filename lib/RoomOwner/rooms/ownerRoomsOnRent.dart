import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'RoomDetailsPageOwner.dart';
import 'choose_category_page.dart';

class OwnerRoomsOnRent extends StatefulWidget {
  const OwnerRoomsOnRent({super.key});

  @override
  State<OwnerRoomsOnRent> createState() => _OwnerRoomsOnRentState();
}

class _OwnerRoomsOnRentState extends State<OwnerRoomsOnRent> {
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
        title: const Text("Rooms on Rent"),
      ),
      body: Column(children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Rooms').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final documents = snapshot.data!.docs;
                    final ownerDocuments = documents.where((doc) {
                      final data = doc.data()
                          as Map<String, dynamic>?; // Explicit type cast
                      final ownerName = data?["Owner"];
                      final roomStatus = data?["Status"];
                      var searchString = email;
                      const status = "On Rent";
                      return ownerName != null &&
                          ownerName.contains(searchString) &&
                          roomStatus?.contains(status) ==
                              true; // Use null-aware operator
                    }).toList();
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      padding: const EdgeInsets.all(10),
                      children: ownerDocuments.map((document) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RoomDetailsPageOwner(document),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 27, 91, 118),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.network(
                                      document['imageUrl'],
                                      height: 140,
                                      width: 180,
                                      fit: BoxFit.fill,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          document['Location'],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        const Text(
                                          ' | Rs ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          document['Rate'],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }).toList(),
                    );
                  } else {
                    return Column(
                      children: const [
                        Text(
                          "No any rooms on Rent!",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    );
                  }
                }))
      ]),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_rental/customer/customerCurrentRent.dart';
// import 'package:room_rental/RoomOwner/profile.dart';
import 'package:room_rental/customer/customerProfile.dart';
import 'package:room_rental/customer/customerRoomDetailsPage.dart';
// import 'package:room_rental/rooms/add_rooms_page.dart';
import 'package:room_rental/utils/customerSidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customerRoomsOnRent extends StatefulWidget {
  // final String email;
  const customerRoomsOnRent({Key? key}) : super(key: key);

  @override
  State<customerRoomsOnRent> createState() => _customerRoomsOnRentState();
}

class _customerRoomsOnRentState extends State<customerRoomsOnRent> {
  String email = '';

final id= '';
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

  List<Widget> pages = [
    // const CustomerHomePage(),
    // const ProfilePage(),
  ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 27, 91, 118), // Set the desired background color here
        title: const Text('Rooms on Rent'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_2_outlined,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              // Perform notifications action
              // Navigate to the new page/screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Rents').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final documents = snapshot.data!.docs;
                    final ownerDocuments = documents.where((doc) {
                      final data = doc.data()
                          as Map<String, dynamic>?; // Explicit type cast
                      final renterName = data?["Renter"];
                      final roomStatus = data?["Status"];
                      final id = data?['RoomId'];
                      var searchString = email;
                      const status = "On Rent";
                      return renterName != null &&
                          renterName.contains(searchString) &&
                          roomStatus?.contains(status) ==
                              true; // Use null-aware operator
                    }).toList();

                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    padding: const EdgeInsets.all(5),
                    children: ownerDocuments.map((document) {
                    final data = document.data()
                         as Map<String, dynamic>?; // Explicit type cast
                      final renter = data?["Renter"];
                      final documentId = document.id;
                      final roomId = data?["RoomId"];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>CustomerRentDetailsPage(documentId: documentId,roomId: roomId.toString()),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      document['Location'],
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    const Text(
                                      ' | Rs',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      document['Rate'],
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: currentPage,
        onTap: (int index) {
          setState(() {
            currentPage = index;
          });

          if (index == 0) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const CustomerHomePage(),
            //   ),
            // );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerProfilePage(),
              ),
            );
          }
        },
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

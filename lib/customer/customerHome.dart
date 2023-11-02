import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:room_rental/RoomOwner/profile.dart';
import 'package:room_rental/customer/customerProfile.dart';
import 'package:room_rental/customer/customerRecommendPage.dart';
import 'package:room_rental/customer/customerRoomDetailsPage.dart';
// import 'package:room_rental/rooms/add_rooms_page.dart';
import 'package:room_rental/utils/customerSidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerHomePage extends StatefulWidget {
  // final String email;
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  String email = '';

  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 27, 91, 118),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 27, 91, 118),
          selectedItemColor: Color.fromARGB(255, 106, 238, 243),
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedIconTheme: IconThemeData(size: 24),
          selectedLabelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 12),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hamro Room'),
          backgroundColor: const Color.fromARGB(255, 27, 91, 118), //
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerProfilePage()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Locations',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  // Set the background color of the TextField here
                  filled: true,
                  fillColor: Colors.grey[
                      200], // Replace this color with the desired background color
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value.trim();
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 0, bottom: 10),
              width: 1000, // Specify the desired width of the rectangle
              height: 160, // Specify the desired height of the rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const RadialGradient(
                    colors: [
                      Color.fromARGB(255, 9, 89, 139),
                      Color.fromARGB(255, 11, 52, 74)
                    ], // Define your gradient colors
                    center: Alignment.center,
                    radius: 1.75),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'Do you want us to recommend a good neighborhood for you?',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerRecommendPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "Recommend Me",
                        style: TextStyle(
                          color: Color.fromARGB(255, 195, 86, 2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Set the desired color of the rectangle
            ),
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
                      final id = data?['id'];
                      var searchString = email;
                      const status = "Open";
                      return ownerName != null &&
                          !ownerName.contains(searchString) &&
                          roomStatus?.contains(status) == true;
                    }).toList();

                    // Filter the documents based on search text
                    final filteredDocuments = ownerDocuments.where((document) {
                      final location =
                          document['Location'].toString().toLowerCase();
                      final searchQuery = _searchText.toLowerCase();
                      return location.contains(searchQuery);
                    }).toList();

                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      padding: const EdgeInsets.all(15),
                      children: filteredDocuments.map((document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerRoomDetails(
                                  documentId: document['id'].toString(),
                                ),
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
                                    height: 130,
                                    width: 140,
                                    fit: BoxFit.fill,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document['Location'],
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      const Text(
                                        ' | Rs',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      Text(
                                        document['Rate'],
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
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
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Profile',
              // Set the color for the label text
            )
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
          backgroundColor: const Color.fromARGB(255, 27, 91, 118), //
        ),
        backgroundColor: const Color(0xFF2284AE),
        drawer: const CustomerSidebar(),
      ),
    );
  }
}

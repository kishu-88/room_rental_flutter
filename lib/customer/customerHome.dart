import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:room_rental/RoomOwner/profile.dart';
import 'package:room_rental/customer/customerProfile.dart';
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
          backgroundColor: const Color.fromARGB(
              255, 27, 91, 118), // Set the desired background color here
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: const Text('Hamro Room'),
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
            Container(
              margin: const EdgeInsets.all(24),
              width: 1000, // Specify the desired width of the rectangle
              height: 130, // Specify the desired height of the rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 195, 86, 2),
              ),
              alignment: Alignment.center,

              child: Column(
                children:  [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Do you want us to recommend good neighbourhood for you?',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(onPressed: (){}, child: const Text("Recommend Me",style:TextStyle(color: Color.fromARGB(255, 195, 86, 2),
),),
                     style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),),
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
                    final currentUserEmail = email;

                    final filteredDocuments = documents.where((doc) {
                      final data = doc.data()
                          as Map<String, dynamic>?; // Explicit type cast
                      final fieldValue =
                          data?["Owner"] as String?; // Explicit type cast

                      return fieldValue != currentUserEmail;
                    }).toList();
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      padding: const EdgeInsets.all(10),
                      children: filteredDocuments.map((document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CustomerRoomDetails(document: document),
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
        drawer: const CustomerSidebar(),
      ),
    );
  }
}

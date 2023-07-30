import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:room_rental/RoomOwner/ownerProfile.dart';
import 'package:room_rental/RoomOwner/rooms/RoomDetailsPageOwner.dart';
import 'package:room_rental/RoomOwner/rooms/choose_category_page.dart';
// import 'package:room_rental/rooms/add_rooms_page.dart';
import 'package:room_rental/utils/OwnerSidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rxdart/rxdart.dart';

class OwnerHomePage extends StatefulWidget {
  // final String email;
  const OwnerHomePage({Key? key}) : super(key: key);

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  String email = '';

  @override
  void initState() {
    super.initState();
    requestPermission();
    getEmail().then((value) {
      setState(() {
        email = value ?? '';
      });
    });
  }


void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert:true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User granted permission");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User granted provisional permission");
    }else{
      print("User not granted permission");
    }
  }
  
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  List<Widget> pages = [
    // const OwnerHomePage(),
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
                    builder: (context) => const ProfilePage(),
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
              height: 120, // Specify the desired height of the rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 27, 91, 118),
              ),
              alignment: Alignment.center,

              child: const Text(
                'My Rooms',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              // Set the desired color of the rectangle
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Rooms').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final documents = snapshot.data!.docs;
                        final currentUserEmail = email;
                        
                         final filteredDocuments = documents.where((doc) {
                          final data = doc.data() as Map<String, dynamic>?; // Explicit type cast
                          final fieldValue = data?["Owner"] as String?; // Explicit type cast

                          return fieldValue == currentUserEmail;
                        }).toList();
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing:10,
                        mainAxisSpacing: 15,
                        padding: const EdgeInsets.all(20),
                        children: filteredDocuments.map((document) {
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
                                child: SizedBox(
                                height: 50, // You can adjust this height as needed
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            document['imageUrl'],
                                            height: double.infinity, // Take full height of the container
                                                width: double.infinity, // Take full width of the container
                                                fit: BoxFit.cover, // Maintain aspect ratio and cover the container
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              document['Location'],
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            const Text(
                                              ' | Rs ',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              document['Rate'],
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }).toList(),
                      );
                    } else {
                      return Column(
                        children: [
                          const Text(
                            "You have not added any rooms!",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ChooseCategoryPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow),
                            child: const Text(
                              "Add Room",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                  }
              )
            )
          ]
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
              //     builder: (context) => const OwnerHomePage(),
              //   ),
              // );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            }
          },
        ),
          backgroundColor: const Color(0xFF2284AE),
        drawer: const OwnerSidebar(),
      ),
    );
  }
}

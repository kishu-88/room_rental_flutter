import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:room_rental/RoomOwner/profile.dart';
import 'package:room_rental/customer/customerRoomDetailsPage.dart';
// import 'package:room_rental/rooms/add_rooms_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRecommendPage extends StatefulWidget {
  // final String email;
  const CustomerRecommendPage({Key? key}) : super(key: key);

  @override
  State<CustomerRecommendPage> createState() => _CustomerRecommendPageState();
}

class _CustomerRecommendPageState extends State<CustomerRecommendPage> {
  String? preferredLocation; // Declare the variable here

  String email = '';

  bool showMagic = true;
  bool showDetail = false;

  final id = '';

  @override
  void initState() {
    super.initState();
    getEmail().then((value) {
      setState(() {
        email = value ?? '';
      });
      recommendRoom();

      // Set a delay of 5 seconds to hide the preferred location
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          showMagic = false;
          showDetail = true;
        });
      });
    });
  }

  Future<void> recommendRoom() async {
    await recommendRoomForUser(email);
  }

  Future<void> recommendRoomForUser(String userEmail) async {
    try {
      // Step 1: Fetch the user data from the "users" collection
      final userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .get();

      // Check if the user exists
      if (userSnapshot.docs.isEmpty) {
        print("User not found!");
        return;
      }

      // Get the user data
      final userData = userSnapshot.docs.first.data();
      final userOccupation = userData["occupation"];

      // Step 2: Query the "Rents" collection to find documents with the same "occupation" as the user's occupation
      final rentSnapshot = await FirebaseFirestore.instance
          .collection("Rents")
          .where("occupation", isEqualTo: userOccupation)
          .get();

      // Step 3: Count the occurrences of each "Location" in the matching documents
      final locationCount = <String, int>{};
      rentSnapshot.docs.forEach((rentDoc) {
        final location = rentDoc["Location"] as String?;
        if (location != null) {
          locationCount[location] = (locationCount[location] ?? 0) + 1;
        }
      });

      // Step 4: Find the most preferred location by the occupation group
      String? mostPreferredLocation;
      int maxCount = 0;
      locationCount.forEach(
        (location, count) {
          if (count > maxCount) {
            mostPreferredLocation = location;
            maxCount = count;
          }
        },
      );
      setState(() {
        preferredLocation = mostPreferredLocation; // Set the value here
      });
      print("Recommended location for $userOccupation: $mostPreferredLocation");
    } catch (e) {
      print("Error recommending room: $e");
    }
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
        title: const Text('Room Recommendations'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment
                .center, // Align children horizontally centered
            children: [
              Visibility(
                visible: showMagic,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(
                          seconds: 10), // Adjust the duration as desired
                      width: MediaQuery.of(context).size.width,
                      curve: Curves.bounceIn,
                      child: const Icon(
                        Icons.mood,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Please Wait Creating Magic For You",
                      style: TextStyle(color: Colors.white),
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              ),
              Visibility(
                visible: showDetail,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)), // Rounded corners
                  ),
                  child: preferredLocation == null
                      ? const CircularProgressIndicator()
                      : Text(
                          "Most Preferred location in your circle: $preferredLocation",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Visibility(
                visible: showDetail,
                child: Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Rooms')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final documents = snapshot.data!.docs;
                            final filteredDocuments = documents.where((doc) {
                              final data = doc.data() as Map<String,
                                  dynamic>?; // Explicit type cast
                              final currentuser = data?["Owner"];
                              final roomStatus = data?["Status"];
                              final location = data?["Location"];
                              final id = data?['RoomId'];
                              var searchString = email;
                              return currentuser != null &&
                                  !currentuser.contains(searchString) &&
                                  roomStatus == "Open" &&
                                  location == preferredLocation;
                            }).toList();
                            return GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                              padding: const EdgeInsets.all(15),
                              children: filteredDocuments.map((document) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerRoomDetails(
                                            documentId:
                                                document['id'].toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color.fromARGB(
                                            255, 27, 91, 118),
                                      ),
                                      child: SizedBox(
                                        height:
                                            50, // You can adjust this height as needed
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Image.network(
                                                  document['imageUrl'],
                                                  height: double
                                                      .infinity, // Take full height of the container
                                                  width: double
                                                      .infinity, // Take full width of the container
                                                  fit: BoxFit.cover,
                                                  // Maintain aspect ratio and cover the container
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
                            return const Column(
                              children: [
                                Text(
                                  "No rooms available in sukkhanagar for rent.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            );
                          }
                        })),
              )
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

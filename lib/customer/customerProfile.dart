import 'package:flutter/material.dart';
import 'package:room_rental/RoomOwner/ownerHome.dart';
import 'package:room_rental/authentication/login_options.dart';
import 'package:room_rental/customer/customerEditProfile.dart';
import 'package:room_rental/customer/customerHome.dart';
// import 'package:room_rental/customer.dart';
import 'package:room_rental/utils/OwnerSidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({Key? key}) : super(key: key);
  // final String email;

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
    String email = '';
  String fullname = "";
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    fetchEmailAndCustomerInfo();
  }
Future<void> fetchEmailAndCustomerInfo() async {
    // Fetch email from SharedPreferences
    String? userEmail = await getEmail();
    setState(() {
      email = userEmail ?? '';
    });

    // Fetch customer info using the retrieved email
    fetchCustomerInfo();
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  void fetchCustomerInfo() async {
    print("fetch customer");
    print("${email}hi");
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get();

      if (snapshot.exists) {
        print("found document");
        // Retrieve customer information from the document
        setState(() {
          fullname = snapshot['fullname'];
          email = snapshot['email'];
          imageUrl = snapshot['imageUrl'];
          // Set other customer information variables here
        });
      }
    } catch (error) {
      print('Error fetching customer info: $error');
    }
  }

  int currentPage = 1;

  void logout(BuildContext context) async {
    // Remove the stored email from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  @override
  Widget build(BuildContext context) {
      String image = imageUrl;
      bool imageIsSet = image != ""; // 
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
              255, 27, 91, 118),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
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
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                logout(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginOptions()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 27, 91, 118),
                ),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Visibility(
                    visible : imageIsSet,
                    child: Image.network(
                       imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
               Text(
                fullname,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  email,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Perform edit profile action
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const EditCustomerProfile()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF1B5B76),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Perform settings action
                            },
                          ),
                          const Text(
                            "Profile Settings",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Perform navigation action
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF1B5B76),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.attach_money,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Perform billing action
                            },
                          ),
                          const Text(
                            "Billing Information",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Perform navigation action
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF1B5B76),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Perform more information action
                            },
                          ),
                          const Text(
                            "More Information",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Perform navigation action
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerHomePage(),
                  // builder: (context) => const CustomerPage(),
                ),
              );
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
        drawer: const OwnerSidebar(),
      ),
    );
  }
}

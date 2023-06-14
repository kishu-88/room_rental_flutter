import 'package:flutter/material.dart';
import 'package:room_rental/home.dart';
import 'package:room_rental/rooms/add_rooms_page.dart';

void main(List<String> args) {
  runApp(const ProfilePage()); // must include at the beginning
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentPage = 0;
  List<Widget> pages = [
    // const ProfilePage(),
    // const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Color(0xFFFFFFFF),
              ),
              onPressed: () {
                // Perform notifications action
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                width: 200, // Specify the desired width of the rectangle
                height: 200, // Specify the desired height of the rectangle
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 27, 91, 118),
                ),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('images/profile_pic.jpg',
                      height: 200, width: 200),
                ),
              ),
              const Text(
                "Kishu88",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: const Text(
                  "Kishoraryal72@gmail.com",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellow),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
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
                              color: Color(0xFFFFFFFF),
                            ),
                            onPressed: () {
                              // Perform notifications action
                            },
                          ),
                          const Text(
                            "Profile Settings",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFFFFFFFF),
                            ),
                            onPressed: () {
                              // Perform notifications action
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
                              color: Color(0xFFFFFFFF),
                            ),
                            onPressed: () {
                              // Perform notifications action
                            },
                          ),
                          const Text(
                            "Billing Information",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFFFFFFFF),
                            ),
                            onPressed: () {
                              // Perform notifications action
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
                              color: Color(0xFFFFFFFF),
                            ),
                            onPressed: () {
                              // Perform notifications action
                            },
                          ),
                          const Text(
                            "More Information",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFFFFFFFF),
                            ),
                            onPressed: () {
                              // Perform notifications action
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
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 27, 91, 118),
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Color(0xFFFFFFFF),
              ),
              label: 'Home',
            ),
            // NavigationDestination(icon: Icon(Icons.send,color: Color(0xFFFFFFFF),), label: 'Messages'),
            // NavigationDestination(icon: Icon(Icons.notifications,color: Color(0xFFFFFFFF),), label: 'Notifications'),
            NavigationDestination(
                icon: Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
                label: 'Profile')
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
        backgroundColor: const Color(0xFF2284AE),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 27, 91, 118),
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Image.asset('images/logo_opaque.png'),
              // const DrawerHeader(

              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //   ),
              //   child: Text('Drawer Header'),
              // ),
              ListTile(
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                  },
                  leading: const Icon(
                    Icons.home,
                    color: Color(0xFFFFFFFF),
                  )),
              const Divider(
                height: 10,
                thickness: 1,
                endIndent: 0,
                color: Colors.white,
              ),
              ListTile(
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                onTap: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                },
                leading: const Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 1,
                endIndent: 0,
                color: Colors.white,
              ),
              ListTile(
                  title: const Text(
                    'List Rooms',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.list,
                    color: Color(0xFFFFFFFF),
                  )),
              const Divider(
                height: 10,
                thickness: 1,
                endIndent: 0,
                color: Colors.white,
              ),
              ListTile(
                title: const Text(
                  'Add Rooms',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                onTap: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddRoomsPage(),
                          ),
                        );
                },
                leading: const Badge(
                  child: Icon(
                    Icons.add,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 1,
                endIndent: 0,
                color: Colors.white,
              ),
              ListTile(
                  title: const Text(
                    'Booking Requests',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.arrow_circle_up,
                    color: Color(0xFFFFFFFF),
                  )),
              const Divider(
                height: 10,
                thickness: 1,
                endIndent: 0,
                color: Colors.white,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

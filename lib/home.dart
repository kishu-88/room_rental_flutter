import 'package:flutter/material.dart';
import 'package:room_rental/profile.dart';
import 'package:room_rental/rooms/choose_category_page.dart';

void main(List<String> args) {
  runApp(const HomePage()); // must include at the beginning
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    const HomePage(),
    const ProfilePage(),
  ];
  int currentPage = 0;
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
        body: 
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
            "My Rooms",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          // Set the desired color of the rectangle
        ),
        
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 27, 91, 118),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home,color: Color(0xFFFFFFFF),), label: 'Home',),
          // NavigationDestination(icon: Icon(Icons.send,color: Color(0xFFFFFFFF),), label: 'Messages'),
          // NavigationDestination(icon: Icon(Icons.notifications,color: Color(0xFFFFFFFF),), label: 'Notifications'),
          NavigationDestination(icon: Icon(Icons.person,color: Color(0xFFFFFFFF),), label: 'Profile')
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
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
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.pop(context);
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
                            builder: (context) => const ChooseCategoryPage(),
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

import 'package:flutter/material.dart';
import 'package:room_rental/home.dart';
// import 'package:room_rental/customer.dart';
import 'package:room_rental/rooms/add_rooms_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Room Rental',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentPage = 1;

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
                Icons.person_outline,
                color: Colors.white,
              ),
              onPressed: () {
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
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 27, 91, 118),
                ),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'images/profile_pic.jpg',
                    height: 200,
                    width: 200,
                  ),
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
                  onPressed: () {
                    // Perform edit profile action
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
                  builder: (context) => const HomePage(),
                  // builder: (context) => const CustomerPage(),
                ),
              );
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
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 27, 91, 118),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Image.asset('images/logo_opaque.png'),
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
                      // builder: (context) => const CustomerPage(),
                    ),
                  );
                },
                leading: const Icon(
                  Icons.home,
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
                ),
              ),
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

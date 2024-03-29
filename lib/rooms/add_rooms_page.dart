import 'package:flutter/material.dart';
import 'package:room_rental/home.dart';

import '../profile.dart';

void main(List<String> args) {
  runApp(const AddRoomsPage()); // must include at the beginning
}

class AddRoomsPage extends StatefulWidget {
  const AddRoomsPage({super.key});

  @override
  State<AddRoomsPage> createState() => _AddRoomsPageState();
}

class _AddRoomsPageState extends State<AddRoomsPage> {
  int currentPage = 0;
  List<Widget> pages = [
    // const ProfilePage(),
    // const ProfilePage(),
  ];

  // Initial Selected Value
  String preferenceDropdownvalue = 'Choose Your Preference';

  String locationDropdownvalue = 'Choose Your Location';

  String roomNumberDropdownvalue = 'No. of rooms';

  // List of preferences items in our dropdown menu
  var preferenceItems = [
    'Choose Your Preference',
    'Family',
    'Student',
    'Business Person'
  ];

  // List of preferences items in our dropdown menu
  var locationItems = [
    'Choose Your Location',
    'Manigram',
    'Nayamill',
    'Drivertole',
    'Shankarnagar'
  ];

  // List of preferences items in our dropdown menu
  var roomNumbers = [
    'No. of rooms',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7'
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
          title: const Text('Add Room'),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.logout,
          //       color: Color(0xFFFFFFFF),
          //     ),
          //     onPressed: () {
          //       // Perform notifications action
          //     },
          //   ),
          // ],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Location',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Size(ft)',
                  ),
                ),
              ),
                Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                // decoration: const BoxDecoration(
                //   color: Colors.amber,),
                child: DropdownButton(
                  // Initial Value
                  value: roomNumberDropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: roomNumbers.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      roomNumberDropdownvalue = newValue!;
                    });
                  },
                ),
              ),
               Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                // decoration: const BoxDecoration(
                //   color: Colors.amber,),
                child: DropdownButton(
                  // Initial Value
                  value: locationDropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: locationItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      locationDropdownvalue = newValue!;
                    });
                  },
                ),
              ),
                Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                // decoration: const BoxDecoration(
                //   color: Colors.amber,),
                child: DropdownButton(
                  // Initial Value
                  value: preferenceDropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: preferenceItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      preferenceDropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  // controller: '_costController',
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Cost(Rs.)',
                  ),
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
                    "Add Room",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  // Navigator.pop(context);
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

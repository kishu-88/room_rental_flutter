import 'package:flutter/material.dart';
import 'package:room_rental/RoomOwner/rooms/bookingRequestsNoti.dart';

import '../RoomOwner/ownerProfile.dart';
import '../RoomOwner/rooms/choose_category_page.dart';

class OwnerSidebar extends StatefulWidget {
  const OwnerSidebar({super.key});

  @override
  State<OwnerSidebar> createState() => _OwnerSidebarState();
}

class _OwnerSidebarState extends State<OwnerSidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const GoogleLogin(),
                    //   ),
                    // );
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
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const bookingRequestNotiPage(),
                    ),
                  );
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
        );
  }
}
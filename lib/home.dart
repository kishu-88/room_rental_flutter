import 'package:flutter/material.dart';
import 'package:room_rental/test_login.dart';
import 'package:room_rental/profile.dart';
// import 'package:room_rental/rooms/add_rooms_page.dart';
import 'package:room_rental/RoomOwner/rooms/choose_category_page.dart';
import 'package:room_rental/utils/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
    // final String email;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
    // const HomePage(),
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
        body: Container(
          margin: const EdgeInsets.all(24),
          width: 1000, // Specify the desired width of the rectangle
          height: 120, // Specify the desired height of the rectangle
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 27, 91, 118),
          ),
          alignment: Alignment.center,

          child:  const Text(
            'My Rooms',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          // Set the desired color of the rectangle
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
              //     builder: (context) => const HomePage(),
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
        drawer: const SideBar(),
      ),
    );
  }
}

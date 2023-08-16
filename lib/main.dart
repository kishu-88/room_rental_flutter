import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'home.dart';
import 'authentication/login_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
 runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue, // Set your desired primary color
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Inter', // Set your desired font family
            fontSize: 20.0, // Set your desired font size
          ),
        ),
      ),
      home: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  List<Widget> pages = [
    // const HomePage(),
    // const ProfilePage(),
  ];

  @override
  void initState() {
  Firebase.initializeApp();
  super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200.0),
                  bottomRight: Radius.circular(200.0),
                ),
                // color: Colors.amber,
            ),
            ),
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200.0),
                  topRight: Radius.circular(200.0),
                  bottomLeft: Radius.circular(200.0),
                  bottomRight: Radius.circular(200.0),
                ),
                color: Color(0xFF2284AE),
                border: Border(
                  left: BorderSide(
                    color: Colors.green,
                    width: 3,
                  ),
                ),
              ),
            ),
            Image.asset('images/hamro_room_logo.png',
                height: 100, width: 250),
            Image.asset('images/hamro_room_logo_text.png',
                height: 100, width: 250),
            const Text("Sharing Spaces, Spreading Happiness",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                  fontFamily: "Inter",
                )),
            Container(
              padding: EdgeInsets.only(top: 40),
              // margin:const EdgeInsets.only(top: 500.0, bottom: 100.0, left: 100.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginOptions()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Set the desired color of the rectangle
        backgroundColor: const Color(0xFF2284AE),
      );
  }
}

import 'package:flutter/material.dart';

// import 'home.dart';
import 'login_options.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 600,
              width: 1000,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150.0),
                  bottomRight: Radius.circular(150.0),
                ),
                color: Color(0xFF1B5B76),
                border: Border(
                  left: BorderSide(
                    color: Colors.green,
                    width: 3,
                  ),
                ),
              ),
            ),
            Container(
              // padding: const EdgeInsets.all(1),
              margin:
                  const EdgeInsets.only(top: 750.0, bottom: 60.0, left: 130.0),

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
                child: Column(
                  children: const [
                    Text(
                      'Get Started',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    // Icon(Icons.people)
                  ],
                ),
              ),
            ),
            Positioned(
              top: 500,
              left: 110,
              child: Container(
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
                // border1Radius: BorderRadius.circular(16.0),
                child: const Text(
                  "nice work",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            Positioned(
              top: 510,
              left: 85,
              child: Image.asset('images/hamro_room_logo.png',
                  height: 100, width: 250),
            ),
            Positioned(
              top: 580,
              left: 85,
              child: Image.asset('images/hamro_room_logo_text.png',
                  height: 100, width: 250),
            ),
            const Positioned(
              top: 670,
              left: 15,
              child: Text("Sharing Spaces, Spreading Happiness",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 22,
                  )),
            )
          ],
        ),
        // Set the desired color of the rectangle
        backgroundColor: const Color(0xFF2284AE),
      ),
    );
  }
}

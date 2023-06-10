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
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
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
              top: MediaQuery.of(context).size.height * 0.6,
              left: (MediaQuery.of(context).size.width - 200) / 2,
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
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              left: (MediaQuery.of(context).size.width - 250) / 2,
              child: Image.asset('images/hamro_room_logo.png',
                  height: 100, width: 250),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              left: (MediaQuery.of(context).size.width - 250) / 2,
              child: Image.asset('images/hamro_room_logo_text.png',
                  height: 100, width: 250),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.8,
              left: (MediaQuery.of(context).size.width - 375) / 2,
              child: const Text("Sharing Spaces, Spreading Happiness",
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

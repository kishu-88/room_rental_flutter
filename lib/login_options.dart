import 'package:flutter/material.dart';

import 'home.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            width: 1000, // Specify the desired width of the rectangle
            height: 120, // Specify the desired height of the rectangle
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 27, 91, 118),
            ),
            alignment: Alignment.center,

            child: Column(
              children: [
                Container(
                    // margin: const EdgeInsets.all(55),
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      child: const Text(
                        'Room Owner',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    )),
                Container(
                    // margin: const EdgeInsets.all(55),
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the new page/screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      child: const Text(
                        'Customer',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    )),
              ],
            ),
            // Set the desired color of the rectangle
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
      ),
    );  }
}
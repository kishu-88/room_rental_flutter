import 'package:flutter/material.dart';

class bookingRequestNotiPage extends StatefulWidget {
  const bookingRequestNotiPage({super.key});

  @override
  State<bookingRequestNotiPage> createState() => _bookingRequestNotiPageState();
}

class _bookingRequestNotiPageState extends State<bookingRequestNotiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Requests"),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
      ),
      body: Container(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          decoration: const BoxDecoration(
            color: Color(0xFF2284AE),
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color:Colors.amber,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 27, 91, 118),
                          borderRadius: BorderRadius.circular(55),
                        ),
                        child: const Icon(
                          Icons.location_city_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: const Text(
                          "You have a booking request",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

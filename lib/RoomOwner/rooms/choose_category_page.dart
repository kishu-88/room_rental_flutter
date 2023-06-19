import 'package:flutter/material.dart';
import 'package:room_rental/RoomOwner/rooms/add_rooms_page.dart';
import 'package:room_rental/RoomOwner/rooms/add_flat_page.dart';

class ChooseCategoryPage extends StatefulWidget {
  const ChooseCategoryPage({super.key});

  @override
  State<ChooseCategoryPage> createState() => _ChooseCategoryPageState();
}

class _ChooseCategoryPageState extends State<ChooseCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Category"),
        backgroundColor: const Color.fromARGB(255, 27, 91, 118),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF2284AE),
        ),
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
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRoomsPage(),
                    ),
                  );
                },
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
                  "Add Rooms",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
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
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddFlatsPage(),
                    ),
                  );
                },
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
                  "Add Flats",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

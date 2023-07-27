import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_rental/RoomOwner/ownerProfile.dart';

class RoomDetailsPageOwner extends StatelessWidget {
    bool isFavorite = false;

  final QueryDocumentSnapshot document;

  RoomDetailsPageOwner(this.document, {super.key});

  @override
  Widget build(BuildContext context) {
    // Use the document data to display room details
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
        actions: [
            IconButton(
              icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: Colors.white,
            ),
              onPressed: () {
              // setState(() {
              //   isFavorite = !isFavorite;
              // });
            },
            ),
          ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            document['imageUrl'],
            height: 300,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            alignment:Alignment.center,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.yellow,
            ),
            child: const Text("Details",style: TextStyle(fontSize: 25),),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Location : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Location'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Floor : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Floor'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Area : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Size'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                 Row(
                  children: [
                    const Text(
                      "Nearest Landmark : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Nearest Landmark'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Parking : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Parking'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                 Row(
                  children: [
                    const Text(
                      "Preference : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Preference'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                 Row(
                  children: [
                    const Text(
                      "Owner : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Owner'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                 Row(
                  children: [
                    const Text(
                      "Rate : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Rate'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                 Row(
                  children: [
                    const Text(
                      "Is Rate Negotiable? : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Negotiability'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Status : ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      document['Status'],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
               
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                  child: const Text(
                    'Edit Room Details',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
          // Add more room details as needed
        ],
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

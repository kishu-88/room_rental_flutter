import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot document;

  RoomDetailsPage(this.document);

  @override
  Widget build(BuildContext context) {
    // Use the document data to display room details
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
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
          Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Location : ",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  Text(
                    document['Location'],
                    style: const TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Floor : ",
                    style:  TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  Text(
                    document['Floor'],
                    style: const TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Area : ",
                    style:  TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  Text(
                    document['Size'],
                    style: const TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          // Add more room details as needed
        ],
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

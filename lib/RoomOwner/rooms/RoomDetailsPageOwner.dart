import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_rental/RoomOwner/ownerHome.dart';
import 'package:room_rental/RoomOwner/ownerProfile.dart';

class RoomDetailsPageOwner extends StatelessWidget {
  bool isFavorite = false;

  final QueryDocumentSnapshot document;

  RoomDetailsPageOwner(this.document, {super.key});

  Future<bool> deleteRoom(String roomId, String status) async {
    try {
      // Reference to the Firestore collection
      CollectionReference roomsCollection =
          FirebaseFirestore.instance.collection('Rooms');

      if (status != 'On Rent') {
        // Delete the document if the status is not "On Rent"
        await roomsCollection.doc(roomId).delete();
        print('Room deleted successfully');
        return true; // Return true to indicate successful deletion
      } else {
        print('Cannot delete room with status "On Rent"');
        return false; // Return false to indicate failed deletion
      }
    } catch (e) {
      print('Error deleting room: $e');
      return false; // Return false to indicate failed deletion
    }
  }

void freeRoom(String roomId) {
  print(roomId);
  // Reference to the document in the 'Rooms' collection with the provided roomId
  DocumentReference roomRef = FirebaseFirestore.instance.collection('Rooms').doc(roomId);

  // Update the 'status' field to 'open'
  roomRef.update({'Status': 'Open','Renter':''}).then((_) {
    print('Room status updated successfully to "open" for roomId: $roomId');
  }).catchError((error) {
    print('Error updating room status: $error');
  });
}
  @override
  Widget build(BuildContext context) {
    String rentStatus = document['Status'];
    bool rentButtonVisibility =
        rentStatus == "On Rent"; // Use the condition directly
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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              document['imageUrl'],
              height: 300,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.yellow,
              ),
              child: const Text(
                "Details",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Location : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Location'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Floor : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Floor'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Area : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Size'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Nearest Landmark : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Nearest Landmark'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Parking : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Parking'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Preference : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Preference'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Owner : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Owner'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Rate : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Rate'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Is Rate Negotiable? : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Negotiability'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Status : ",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        document['Status'],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        SizedBox(
                            width:
                                8), // Add some spacing between the icon and text
                        Text(
                          'Edit Room',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.yellow, // Set the background color to yellow
                      padding: EdgeInsets.all(10), // Adjust padding as needed
                      // You can customize other properties here, such as textStyle, shape, elevation, etc.
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      var roomId = document['id'];
                      String status =
                          document['Status']; // Replace with the actual roomId
                      // Show a confirmation dialog before proceeding with deletion
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: StatefulBuilder(
                              // Wrap the content with StatefulBuilder to update the dialog content
                              builder: (context, setState) {
                                String errorMessage =
                                    ''; // Variable to hold the error message

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Are you sure you want to delete this room?'),
                                    if (errorMessage.isNotEmpty)
                                      Text(
                                        errorMessage,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            bool deleteSuccess =
                                                await deleteRoom(
                                                    roomId.toString(), status);
                                            if (deleteSuccess) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OwnerHomePage(),
                                                ),
                                              );
                                            } else {
                                              // Set the error message to be displayed in the dialog
                                              setState(() {
                                                errorMessage =
                                                    'Cannot delete room with status "On Rent"';
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ), // Add some spacing between the icon and text
                        Text(
                          'Delete Room',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: rentButtonVisibility,
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        var roomId = document['id'];
                        freeRoom(roomId.toString(),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.login,
                            color: Colors.black,
                          ),
                          SizedBox(
                              width:
                                  2), // Add some spacing between the icon and text
                          Text(
                            'Free Room',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // Set the background color to yellow
                        padding: EdgeInsets.all(10), // Adjust padding as needed
                        // You can customize other properties here, such as textStyle, shape, elevation, etc.
                      ),
                    ),
                  ),
                ),
              ],
            ), // Add more room details as needed
          ],
        ),
      ),
      backgroundColor: const Color(0xFF2284AE),
    );
  }
}

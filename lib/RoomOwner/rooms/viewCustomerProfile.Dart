import 'package:flutter/material.dart';
import 'package:room_rental/RoomOwner/ownerHome.dart';
import 'package:room_rental/authentication/login_options.dart';
// import 'package:room_rental/customer.dart';
import 'package:room_rental/RoomOwner/rooms/add_rooms_page.dart';
import 'package:room_rental/authentication/roomOwner/roomOwnerLoginPage.dart';
import 'package:room_rental/utils/OwnerSidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../rooms/bookingRequestPage.dart';


class ViewCustomerProfilePage extends StatefulWidget {
  const ViewCustomerProfilePage({Key? key}) : super(key: key);
  // final String email;

  @override
  State<ViewCustomerProfilePage> createState() => _ViewCustomerProfilePageState();
}

class _ViewCustomerProfilePageState extends State<ViewCustomerProfilePage> {
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

  int currentPage = 1;

  void logout(BuildContext context) async {
    // Remove the stored email from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (context) => const BookingRequestPage()));
            },
          ),
          title: const Text('Edit Details'),
          backgroundColor: const Color.fromARGB(255, 27, 91, 118),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 27, 91, 118),
                ),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'images/profile_pic.jpg',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              const Text(
                "Kishu88",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  email,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      
        backgroundColor: const Color(0xFF2284AE),
      );
    
  }
}

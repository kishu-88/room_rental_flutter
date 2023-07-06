import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_rental/authentication/login_options.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.white),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signUp,
                    child: Text('Sign Up'),
                  ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 27, 91, 118),
    );
  }

  Future<void> _signUp() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      setState(() {
        _isLoading = true;
      });

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

 FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add a document with a generated ID
    firestore.collection('users').doc(email).set({
      'email': email,
    });
      // Registration successful, navigate to the home page or another screen
      print('User registered: ${userCredential.user!.uid}');

      setState(() {
        _isLoading = false;
      });
        // Navigate to the home page or another screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginOptions()), // Replace 'HomePage' with your desired screen
            );

    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

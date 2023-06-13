import 'package:flutter/material.dart';

class ChooseCategoryPage extends StatefulWidget {
  const ChooseCategoryPage({super.key});

  @override
  State<ChooseCategoryPage> createState() => _ChooseCategoryPageState();
}

class _ChooseCategoryPageState extends State<ChooseCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height:double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T O D O L I S T',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "T O D O L I S T",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
          ),
          body: const HomePage()),
    );
  }
}

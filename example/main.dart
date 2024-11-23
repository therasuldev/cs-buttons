import 'package:csbuttons/csbuttons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("CSButton Example")),
        body: Center(
          child: CSButton(
            icon: Icons.favorite,
            iconSize: 60.0,
            color: Colors.red,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("CSHeartButton Example")),
        body: Center(
          child: CSHeartButton(
            onDoubleTap: () {},
            child: const Text('Double tap the screen'),
          ),
        ),
      ),
    );
  }
}

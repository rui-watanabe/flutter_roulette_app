import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_roulette_app/roulette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:roulette/roulette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            child: Text("次へ"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoulettePage()),
              );
            },
          ),
        ));
  }
}

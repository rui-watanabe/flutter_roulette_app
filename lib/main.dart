import 'dart:math';

import 'package:flutter/material.dart';
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
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late RouletteController _controller;

  @override
  // StatefulWidgetのみ
  void initState() {
    // RouletteControllerを初期化
    _controller = RouletteController(
        group: RouletteGroup([
          const RouletteUnit.text("A", color: Colors.red),
          const RouletteUnit.text("B", color: Colors.green),
          const RouletteUnit.text("C", color: Colors.blue),
          const RouletteUnit.text("D", color: Colors.yellow),
        ]),
        vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ルーレット'),
      ),
      body: Container(
        child: Center(
            child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      // Roulettのcontrollerを設定
                      child: Roulette(
                        controller: _controller,
                        style: const RouletteStyle(
                          dividerThickness: 4,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    FontAwesomeIcons.longArrowAltDown,
                    size: 45,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          onTap: () => _controller.rollTo(
            2,
            clockwise: true,
            // TODO: ランダム値を特定のアクションで操作できるようにする
            offset: Random().nextDouble(),
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

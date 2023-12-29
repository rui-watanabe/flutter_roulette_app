import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:roulette/roulette.dart';

class RoulettePage extends StatefulWidget {
  const RoulettePage({Key? key}) : super(key: key);
  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage>
    with SingleTickerProviderStateMixin {
  late RouletteController _controller;
  final units = [
    const RouletteUnit.text("A", color: Colors.red),
  ];

  @override
  // StatefulWidgetのみ
  void initState() {
    // RouletteControllerを初期化
    _controller = RouletteController(group: RouletteGroup(units), vsync: this);
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

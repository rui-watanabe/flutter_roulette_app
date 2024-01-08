import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_roulette_app/utils/colors.dart';
import 'package:flutter_roulette_app/view/input_dialog.dart';
import 'package:flutter_roulette_app/view/result_text.dart';
import 'package:flutter_roulette_app/view_model/pie_result_view_model.dart';
import 'package:flutter_roulette_app/view_model/pie_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:roulette/roulette.dart';

class RoulettePage extends ConsumerStatefulWidget {
  const RoulettePage({super.key});

  @override
  _RoulettePageState createState() => _RoulettePageState();
}

class _RoulettePageState extends ConsumerState<RoulettePage>
    with SingleTickerProviderStateMixin {
  late RouletteController _controller;

  @override
  // StatefulWidgetのみ
  void initState() {
    super.initState();
    // 初期化時にRouletteControllerを作成
    final group = RouletteGroup.uniform(
      1,
      colorBuilder: (index) => ColorUtils.getRandomColor(),
      textBuilder: (index) => "",
    );
    _controller = RouletteController(group: group, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final pieTargets = ref.watch(PieModelProvider);
    // PieModelProviderが更新されたら、RouletteControllerも更新する
    _controller.group = RouletteGroup.uniform(
      pieTargets.isEmpty ? 1 : pieTargets.length,
      colorBuilder: (index) =>
          pieTargets.isEmpty ? Colors.white : pieTargets[index].color,
      textBuilder: (index) =>
          pieTargets.isEmpty ? "" : pieTargets[index].name.toString(),
    );
    if (pieTargets.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          barrierDismissible: pieTargets.isNotEmpty,
          context: context,
          builder: (BuildContext context) {
            return InputDialog();
          },
        );
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('ルーレット'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return InputDialog();
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Center(
              child: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ResultText(),
                SizedBox(height: 50),
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
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      child: const Text('スタート'),
                      onPressed: () async {
                        int _targetIndex = Random().nextInt(pieTargets.length);
                        //コントローラ動かす
                        await _controller.rollTo(
                          _targetIndex,
                          clockwise: true,
                          offset: Random().nextDouble(),
                        );
                        ref
                            .read(PieResultModelProvider.notifier)
                            .setResultName(pieTargets[_targetIndex].name);
                      },
                    ),
                    SizedBox(width: 40),
                    OutlinedButton(
                      child: const Text('リセット'),
                      onPressed: () {
                        setState(() {
                          ref
                              .read(PieResultModelProvider.notifier)
                              .setResultName("");
                        });
                        ref.read(PieModelProvider.notifier).deleteAllPies();
                      },
                    ),
                  ],
                )
              ],
            ),
            onTap: () async {
              //コントローラ動かす
              await _controller.rollTo(
                0,
                clockwise: true,
                offset: Random().nextDouble(),
              );
              ref
                  .read(PieResultModelProvider.notifier)
                  .setResultName(pieTargets[0].name);
            },
            onDoubleTap: () async {
              //コントローラ動かす
              await _controller.rollTo(
                pieTargets.length - 1,
                clockwise: true,
                offset: Random().nextDouble(),
              );
              ref
                  .read(PieResultModelProvider.notifier)
                  .setResultName(pieTargets[pieTargets.length - 1].name);
            },
          )),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getResultText() {
    return "";
  }
}

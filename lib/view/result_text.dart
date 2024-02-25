import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_roulette_app/view_model/pie_result_view_model.dart';

class ResultText extends ConsumerStatefulWidget {
  const ResultText({Key? key}) : super(key: key);

  @override
  _ResultTextState createState() => _ResultTextState();
}

class _ResultTextState extends ConsumerState<ResultText> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(PieResultModelProvider);
    // return Text(
    //   provider.result,
    //   style: TextStyle(fontSize: 30),
    // );
    return provider.result == ""
        ? Container(child: SizedBox(height: 80))
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
                child: SizedBox(
              width: double.infinity,
              height: 80,
              child: Card(
                child: Container(
                    alignment: Alignment.center, //任意のプロパティ
                    width: double.infinity,
                    child: Text(
                      provider.result,
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    )),
                color: Colors.brown[50], // Card自体の色
                elevation: 8, // 影の離れ具合
                shadowColor: Colors.black, // 影の色
                shape: RoundedRectangleBorder(
                  // 枠線を変更できる
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )));
  }
}

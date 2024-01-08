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
    return Text(
      provider.result,
      style: TextStyle(fontSize: 30),
    );
  }
}

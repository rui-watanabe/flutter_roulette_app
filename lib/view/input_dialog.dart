import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_roulette_app/components/custom_text_button.dart';
import 'package:flutter_roulette_app/utils/colors.dart';
import 'package:flutter_roulette_app/view_model/pie_view_model.dart';

class InputDialog extends ConsumerStatefulWidget {
  const InputDialog({Key? key}) : super(key: key);

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends ConsumerState<InputDialog> {
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("追加")),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
            maxLength: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextButton(
                  text: "キャンセル",
                  onPressed: () {
                    if (ref.read(PieModelProvider).isNotEmpty) {
                      Navigator.pop(context);
                    }
                  }),
              CustomTextButton(
                  text: "追加",
                  onPressed: () {
                    if (_name.isNotEmpty) {
                      ref
                          .read(PieModelProvider.notifier)
                          .addPie(_name, ColorUtils.getRandomColor());
                    }
                    Navigator.pop(context);
                  }),
            ],
          )
        ],
      ),
    );
  }
}

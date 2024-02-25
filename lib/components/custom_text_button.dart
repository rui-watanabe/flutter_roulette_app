import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderSide? border;

  CustomTextButton({
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor,
    this.padding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        padding: padding ?? EdgeInsets.all(8.0),
        textStyle: textStyle ?? TextStyle(fontSize: 16),
        side: border,
      ),
      child: Text(text),
    );
  }
}

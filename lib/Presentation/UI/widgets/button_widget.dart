import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Size? buttonSize;
  final Color? textColor;
  final VoidCallback onPressed;
  const Button({
    super.key,
    required this.buttonText,
    this.buttonSize,
    this.buttonColor,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final defaultButtonWidth = devicewidth * .25;
    final defaultButtonHeight = deviceHeight * .12;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Colors.transparent,
        minimumSize:
            buttonSize ?? Size(defaultButtonWidth, defaultButtonHeight),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 25,
          color: textColor ?? const Color.fromRGBO(199, 199, 199, 1),
        ),
      ),
    );
  }
}

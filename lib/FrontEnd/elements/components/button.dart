import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

class ButtonSatu extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color childColor;
  final Color? borderColor;
  final String buttonText;
  final VoidCallback? onPressed;

  const ButtonSatu({
    Key? key,
    this.width = 250,
    this.backgroundColor = primary,
    this.childColor = bases,
    this.borderColor,
    this.buttonText = '',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed, // Use the provided onPressed callback
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: childColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
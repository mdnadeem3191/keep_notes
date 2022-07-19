import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Color color;
  final double verticalHight;
  final double horizontleWidth;
  final double circularBorder;

  final double elevation;
  const CustomButton({
    required this.child,
    required this.circularBorder,
    required this.elevation,
    required this.onPressed,
    required this.color,
    required this.verticalHight,
    required this.horizontleWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: child,
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
              vertical: verticalHight, horizontal: horizontleWidth),
        ),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularBorder),
          ),
        ),
        elevation: MaterialStateProperty.all(elevation),
      ),
    );
  }
}

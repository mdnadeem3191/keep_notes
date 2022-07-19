import 'package:flutter/material.dart';

class ReUseTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color selectedColor;
  final Color titleColor;
  final Color iconColor;
  final Function() onPressed;
  const ReUseTile({
    required this.titleColor,
    required this.iconColor,
    required this.title,
    required this.icon,
    required this.selectedColor,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(selectedColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 19, color: titleColor),
                ),
              ],
            ),
          )),
    );
  }
}

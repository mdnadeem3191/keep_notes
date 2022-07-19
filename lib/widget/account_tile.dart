import 'package:flutter/material.dart';


import '../const/const.dart';

class AccountTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color iconColor;
  final Widget trailing;
  const AccountTile(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.icon,
      required this.trailing,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1,
          color: black.withOpacity(0.3),
        ),
        ListTile(
            title: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const Text(
                  ":",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(fontSize: 16, color: black.withOpacity(0.9)),
            ),
            trailing: trailing),
      ],
    );
  }
}

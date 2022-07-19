import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/const.dart';
import 'home_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool syncValue = false;
  bool darkModeValue = false;
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height10 = customHeight / 85.257;
final width15 = customWidth / 27.42;

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              icon: const Icon(Icons.arrow_back)),
          Container(
            padding:
                EdgeInsets.symmetric(vertical: height10, horizontal: width15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Syn",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: black),
                    ),
                    Transform.scale(
                      scale: 1.1,
                      child: Switch.adaptive(
                          value: syncValue,
                          // activeColor: green,
                          inactiveThumbColor: red,
                          onChanged: (switchValue) {
                            setState(() {
                              syncValue = switchValue;
                            });
                          }),
                    )
                  ],
                ),
                // Row(                            ..................//Dark Mode
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Dark Mode",
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500,
                //           color: black),
                //     ),
                //     Transform.scale(
                //       scale: 1.1,
                //       child: Switch.adaptive(
                //           value: darkModeValue,
                //           activeColor: white,
                //           inactiveThumbColor: black,
                //           onChanged: (switchValue) {
                //             setState(() {
                //               darkModeValue = switchValue;
                //             });
                //           }),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

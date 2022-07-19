import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/setting.dart';

import '../const/const.dart';
import '../services/sqflite_db.dart';
import '../widget/reusetile_drawer.dart';
import 'account.dart';
import 'archive.dart';
import 'firebase/auth_page.dart';
import 'help_feedback.dart';
import 'home_page.dart';

enum ListTiles { notes, archive, setting, help, account, logout }

ListTiles? selectedColor;

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final height15 = customHeight / 56.838;

    return Drawer(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: width10,
                    right: width10 * 2,
                    top: height10 * 2,
                    bottom: height15),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: Image.asset(
                        "images/2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Keep",
                      style: TextStyle(
                        color: black.withOpacity(0.8),
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              ReUseTile(
                titleColor:
                    selectedColor == ListTiles.notes || selectedColor == null
                        ? red
                        : black.withOpacity(0.8),
                iconColor:
                    selectedColor == ListTiles.notes || selectedColor == null
                        ? red
                        : black.withOpacity(0.8),
                title: "Notes",
                icon: Icons.lightbulb_outline,
                selectedColor:
                    selectedColor == ListTiles.notes || selectedColor == null
                        ? tileColor
                        : white,
                onPressed: () {
                  setState(() {
                    selectedColor = ListTiles.notes;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (Route<dynamic> route) => false);
                },
              ),
              ReUseTile(
                titleColor: selectedColor == ListTiles.archive
                    ? red
                    : black.withOpacity(0.8),
                iconColor: selectedColor == ListTiles.archive
                    ? red
                    : black.withOpacity(0.8),
                title: "Archive",
                icon: Icons.archive_outlined,
                selectedColor:
                    selectedColor == ListTiles.archive ? tileColor : white,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const Archive(),
                      ),
                      (Route<dynamic> route) => false);
                  setState(() {
                    selectedColor = ListTiles.archive;
                  });
                },
              ),
              Divider(
                thickness: 1,
                color: black.withOpacity(0.5),
                indent: width10,
                endIndent: width10 * 2,
              ),
              const SizedBox(
                height: 10,
              ),
              ReUseTile(
                title: "Account",
                titleColor: selectedColor == ListTiles.account
                    ? red
                    : black.withOpacity(0.8),
                iconColor: selectedColor == ListTiles.account
                    ? red
                    : black.withOpacity(0.8),
                icon: Icons.person,
                selectedColor:
                    selectedColor == ListTiles.account ? tileColor : white,
                onPressed: () {
                  setState(() {
                    selectedColor = ListTiles.account;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const Account(),
                      ),
                      (Route<dynamic> route) => false);
                },
              ),
              ReUseTile(
                title: "Settings",
                titleColor: selectedColor == ListTiles.setting
                    ? red
                    : black.withOpacity(0.8),
                iconColor: selectedColor == ListTiles.setting
                    ? red
                    : black.withOpacity(0.8),
                icon: Icons.settings,
                selectedColor:
                    selectedColor == ListTiles.setting ? tileColor : white,
                onPressed: () {
                  setState(() {
                    selectedColor = ListTiles.notes;
                  });
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (context) => const Settings(),
                  ));
                },
              ),
              ReUseTile(
                title: "Help & feedback",
                titleColor: selectedColor == ListTiles.help
                    ? red
                    : black.withOpacity(0.8),
                iconColor: selectedColor == ListTiles.help
                    ? red
                    : black.withOpacity(0.8),
                icon: Icons.help_outline,
                selectedColor:
                    selectedColor == ListTiles.help ? tileColor : white,
                onPressed: () {
                  setState(() {
                    selectedColor = ListTiles.help;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpFeedback(),
                      ));
                },
              ),
              Divider(
                thickness: 1,
                color: black.withOpacity(0.5),
                indent: width10,
                endIndent: width10 * 2,
              ),
              SizedBox(
                height: height10,
              ),
              ReUseTile(
                title: "Logout",
                titleColor: red,
                iconColor: red,
                icon: Icons.logout,
                selectedColor:
                    selectedColor == ListTiles.logout ? tileColor : white,
                onPressed: () async {
                  setState(() {
                    selectedColor = ListTiles.notes;
                  });
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     CupertinoPageRoute(
                  //       builder: (context) => const HomePage(),
                  //     ),
                  //     (Route<dynamic> route) => false);
                  await NotesDataBase.instance.deleteAllNote();

                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AuthPage(),
                      ));
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}

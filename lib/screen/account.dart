import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/change_name.dart';
import 'package:highlark_keep_notes/screen/firebase/auth_page.dart';
import 'package:highlark_keep_notes/services/firestore.dart';
import 'package:highlark_keep_notes/widget/account_tile.dart';
import 'package:highlark_keep_notes/widget/custom_child.dart';
import '../const/const.dart';
import '../services/sqflite_db.dart';
import 'drawer.dart';
import 'firebase/change_email.dart';
import 'firebase/change_password.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  alertDeleteDailog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Are you sure to delete your account permanent",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: black, fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await FirestoreDB().deleteAllNotes();
                  await NotesDataBase.instance.deleteAllNote();

                  await FirebaseAuth.instance.currentUser!.reload();
                  await FirebaseAuth.instance.currentUser!.delete();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const AuthPage(),
                      ));
                },
                child: Text(
                  "Yes",
                  style: TextStyle(color: red, fontSize: 17),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42
    bool isPortait = MediaQuery.of(context).orientation == Orientation.portrait;

    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width15 = customWidth / 27.42;
    final height12 = customHeight / 71.04;

    return WillPopScope(
      onWillPop: () async {
        bool willPop = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Confirm",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                content: const Text(
                  "Do you want to exit",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: red, fontSize: 17),
                    ),
                  )
                ],
              );
            });
        return Future.value(willPop);
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Login & Security",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        drawer: const MyDrawer(),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Notes")
                .doc(currentUser!.email)
                .collection("User")
                .snapshots(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: snapshot.data!.docs.map((document) {
                      return isPortait
                          ? SingleChildScrollView(
                              child: SizedBox(
                                width: customWidth,
                                height: customHeight,
                                child: Column(
                                  children: [
                                    AccountTile(
                                      title: "Name",
                                      subTitle: document['name'],
                                      icon: Icons.person,
                                      iconColor: black.withOpacity(0.8),
                                      trailing: CustomButton(
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(color: black),
                                          ),
                                          circularBorder: 8,
                                          elevation: 0,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const ChangeName(),
                                                ));
                                          },
                                          color: grey.withOpacity(0.5),
                                          verticalHight: height10,
                                          horizontleWidth: width15 + width10),
                                    ),
                                    AccountTile(
                                      trailing: CustomButton(
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(color: black),
                                          ),
                                          circularBorder: 8,
                                          elevation: 0,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const ChangeEmail(),
                                                ));
                                          },
                                          color: grey.withOpacity(0.5),
                                          verticalHight: height10,
                                          horizontleWidth: width15 + width10),
                                      title: "E-mail",
                                      subTitle:
                                          "${FirebaseAuth.instance.currentUser!.email}",
                                      icon: Icons.mail,
                                      iconColor: red.withOpacity(0.9),
                                    ),
                                    AccountTile(
                                        trailing: CustomButton(
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(color: black),
                                            ),
                                            circularBorder: 8,
                                            elevation: 0,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const ChangePassword(),
                                                  ));
                                            },
                                            color: grey.withOpacity(0.5),
                                            verticalHight: height10,
                                            horizontleWidth: width15 + width10),
                                        title: "Password",
                                        subTitle: "********",
                                        icon: Icons.lock,
                                        iconColor: black.withOpacity(0.8)),
                                    Divider(
                                      thickness: 1,
                                      color: black.withOpacity(0.3),
                                    ),
                                    //spacer                         // const Spacer(),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: height12 * 36),
                                      child: CustomButton(
                                          child: Text(
                                            "Delete Account",
                                            style: TextStyle(color: white),
                                          ),
                                          circularBorder: 10,
                                          elevation: 10,
                                          onPressed: () async {
                                            alertDeleteDailog();
                                          },
                                          color: red,
                                          verticalHight: customHeight / 65.58,
                                          horizontleWidth: width15 * 2),
                                    ),
                                    SizedBox(
                                      height: height12 * 2,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                AccountTile(
                                  title: "Name",
                                  subTitle: document['name'],
                                  icon: Icons.person,
                                  iconColor: black.withOpacity(0.8),
                                  trailing: CustomButton(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(color: black),
                                      ),
                                      circularBorder: 8,
                                      elevation: 0,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const ChangeName(),
                                            ));
                                      },
                                      color: grey.withOpacity(0.5),
                                      verticalHight: height10,
                                      horizontleWidth: width15 + width10),
                                ),
                                AccountTile(
                                  trailing: CustomButton(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(color: black),
                                      ),
                                      circularBorder: 8,
                                      elevation: 0,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const ChangeEmail(),
                                            ));
                                      },
                                      color: grey.withOpacity(0.5),
                                      verticalHight: height10,
                                      horizontleWidth: width15 + width10),
                                  title: "E-mail",
                                  subTitle:
                                      "${FirebaseAuth.instance.currentUser!.email}",
                                  icon: Icons.mail,
                                  iconColor: red.withOpacity(0.9),
                                ),
                                AccountTile(
                                    trailing: CustomButton(
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(color: black),
                                        ),
                                        circularBorder: 8,
                                        elevation: 0,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const ChangePassword(),
                                              ));
                                        },
                                        color: grey.withOpacity(0.5),
                                        verticalHight: height10,
                                        horizontleWidth: width10 + width15),
                                    title: "Password",
                                    subTitle: "********",
                                    icon: Icons.lock,
                                    iconColor: black.withOpacity(0.8)),
                                Divider(
                                  thickness: 1,
                                  color: black.withOpacity(0.3),
                                ),
                                // const Spacer(),

                                Container(
                                  padding: EdgeInsets.only(top: height12 * 36),
                                  child: CustomButton(
                                      child: Text(
                                        "Delete Account",
                                        style: TextStyle(color: white),
                                      ),
                                      circularBorder: 10,
                                      elevation: 10,
                                      onPressed: () async {
                                        alertDeleteDailog();
                                      },
                                      color: red,
                                      verticalHight: customHeight / 65.58,
                                      horizontleWidth: width15 * 2),
                                ),
                                SizedBox(height: height12 * 2),
                              ],
                            );
                    }).toList(),
                  )),
      ),
    );
  }
}

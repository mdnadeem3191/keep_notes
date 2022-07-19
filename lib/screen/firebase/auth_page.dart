import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/firebase/login_page.dart';
import 'package:highlark_keep_notes/screen/firebase/create_account.dart';

import '../../const/const.dart';
import '../../widget/custom_child.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42
    bool isPortrait =
        (MediaQuery.of(context).orientation == Orientation.landscape);
    final height70 = customHeight / 12.17;
    final height80 = customHeight / 10.65;
    final height50 = customHeight / 17.05;
    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width70 = customWidth / 5.87;

    return Scaffold(
      backgroundColor: white,
      body: isPortrait
          ? SafeArea(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: customWidth / 2,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: height50, bottom: height50),
                          height: 150,
                          child: Image.asset(
                            "images/12.png",
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: height50 / 2),
                          child: Column(
                            children: const [
                              Text(
                                "Let us get started",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "It helps you keep track of your thoughts and ideas.Notekeeper offer a great possibility to store and secure your ideas. You can always have them at hand and quickly access them.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: customWidth / 2,
                    margin: EdgeInsets.only(top: height50, bottom: height80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: height10 * 2),
                          child: CustomButton(
                            circularBorder: 25,
                            elevation: 5,
                            verticalHight: 12,
                            horizontleWidth: width10 * 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create an Account",
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                                SizedBox(
                                  width: width10 * 2,
                                ),
                                Icon(
                                  FluentIcons.people_add,
                                  color: white,
                                  size: 18,
                                )
                              ],
                            ),
                            color: red,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const CreateAccount(),
                                  ));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: height10 * 2),
                          child: CustomButton(
                            elevation: 10,
                            circularBorder: 25,
                            verticalHight: 12,
                            horizontleWidth: width10 * 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Log In to Account",
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                                SizedBox(
                                  width: width10 * 2,
                                ),
                                Icon(
                                  FluentIcons.signin,
                                  color: white,
                                  size: 18,
                                )
                              ],
                            ),
                            color: black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height70, bottom: height50),
                    height: 200,
                    child: Image.asset(
                      "images/12.png",
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: height50 / 2),
                    child: Column(
                      children: [
                        const Text(
                          "Let us get started",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          discription,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height50, bottom: height80),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: height10 * 2),
                          child: CustomButton(
                            circularBorder: 25,
                            elevation: 5,
                            verticalHight: 12,
                            horizontleWidth: width70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create an Account",
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                                SizedBox(
                                  width: width10 * 2,
                                ),
                                Icon(
                                  FluentIcons.people_add,
                                  color: white,
                                  size: 18,
                                )
                              ],
                            ),
                            color: red,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const CreateAccount(),
                                  ));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: height10 * 2),
                          child: CustomButton(
                            elevation: 10,
                            circularBorder: 25,
                            verticalHight: 12,
                            horizontleWidth: width70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Log In to Account",
                                  style: TextStyle(color: white, fontSize: 18),
                                ),
                                SizedBox(
                                  width: width10 * 2,
                                ),
                                Icon(
                                  FluentIcons.signin,
                                  color: white,
                                  size: 18,
                                )
                              ],
                            ),
                            color: black,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

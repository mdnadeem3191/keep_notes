import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/firebase/create_account.dart';
import 'package:highlark_keep_notes/screen/firebase/verify_forget_password.dart';

import 'package:highlark_keep_notes/widget/custom_child.dart';

import '../../const/const.dart';
import 'login_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final width100 = customWidth / 4.1142;
    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final height15 = customHeight / 56.838;
    final width15 = customWidth / 27.42;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: TextStyle(color: white, fontSize: 18),
        ),
        elevation: 3,
        iconTheme: IconThemeData(color: white),
        backgroundColor: red,
      ),
      body: isPortrait
          ? SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: formkey,
                  child: Row(
                    children: [
                      Container(
                          width: customWidth / 2,
                          padding: EdgeInsets.only(
                              left: width15 + width10,
                              right: width15 + width10,
                              top: height15 * 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Reset Link will be sent to your email id",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: height15 + height10,
                                  ),
                                  TextFormField(
                                    cursorColor: red,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Email is empty";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    controller: email,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black)),
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                            color: black.withOpacity(0.8)),
                                        border: const OutlineInputBorder()),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(top: height15 * 13),
                        width: customWidth / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomButton(
                                  child: Text(
                                    "Send Link",
                                    style: TextStyle(color: white),
                                  ),
                                  elevation: 5,
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      try {
                                        await FirebaseAuth.instance
                                            .sendPasswordResetEmail(
                                                email: email.text);
                                        Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  ForgetPasswordEmailVerification(
                                                      email: email.text),
                                            ));
                                      } on FirebaseException {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("No user found")));
                                      }
                                    }
                                  },
                                  color: red,
                                  verticalHight: 12,
                                  horizontleWidth: width15 * 1,
                                  circularBorder: 10,
                                ),
                                SizedBox(
                                  width: width100 / 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ));
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: width10 / 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const CreateAccount(),
                                        ));
                                  },
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: red),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : SafeArea(
              child: Form(
                key: formkey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width15 + width10 * 2,
                      vertical: height10 * 2),
                  child: Column(
                    children: [
                      const Text(
                        "Reset Link will be sent to your email id",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        height: height15 + height10,
                      ),
                      TextFormField(
                        cursorColor: red,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is empty";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: black)),
                            suffixText: "@gmail.com",
                            labelText: "Email",
                            labelStyle:
                                TextStyle(color: black.withOpacity(0.8)),
                            border: const OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: height10 + height10 * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            child: Text(
                              "Send Link",
                              style: TextStyle(color: white),
                            ),
                            elevation: 5,
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: email.text);
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordEmailVerification(
                                                email: email.text),
                                      ));
                                } on FirebaseException {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("No user found")));
                                }
                              }
                            },
                            color: red,
                            verticalHight: height15,
                            horizontleWidth: width15 * 2,
                            circularBorder: 10,
                          ),
                          SizedBox(
                            width: width100 / 2 + width100 / 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: width10 * 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const CreateAccount(),
                                  ));
                            },
                            child: Text(
                              "Signup",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: red),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

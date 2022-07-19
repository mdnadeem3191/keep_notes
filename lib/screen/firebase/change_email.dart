import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/firebase/verify_email.dart';
import 'package:highlark_keep_notes/widget/custom_child.dart';

import '../../const/const.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmail();
}

class _ChangeEmail extends State<ChangeEmail> {
  TextEditingController newEmail = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double customWidth = MediaQuery.of(context).size.width; //411.42
    double customHeight = MediaQuery.of(context).size.height; //852.57
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final width10 = customWidth / 41.142;
    final height15 = customHeight / 56.838;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          "Notekeeper",
          style: TextStyle(color: black, fontSize: 20),
        ),
        // elevation: 3,
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
      ),
      body: isPortrait
          ? SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: width10 * 1.5,
                          right: width10 * 1.5,
                          top: height15 * 10),
                      width: customWidth / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Notekeeper",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 25,
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
                            controller: newEmail,
                            decoration: InputDecoration(
                              focusColor: black,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: black)),
                              labelText: "New Email",
                              labelStyle:
                                  TextStyle(color: black.withOpacity(0.8)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: width10 * 1.5,
                          right: width10 * 1.5,
                          top: height15 * 14),
                      width: customWidth / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            child: Text(
                              "Discard",
                              style: TextStyle(color: red, fontSize: 18),
                            ),
                            elevation: 0,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: white,
                            verticalHight: 12,
                            horizontleWidth: 20,
                            circularBorder: 10,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomButton(
                            child: Text(
                              "Confirm",
                              style: TextStyle(color: white),
                            ),
                            elevation: 5,
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                await FirebaseAuth.instance.currentUser!
                                    .updateEmail(newEmail.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Please verify your email.")));

                                Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const VerifyEmail(),
                                    ));
                              }
                            },
                            color: red,
                            verticalHight: 14,
                            horizontleWidth: 40,
                            circularBorder: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Form(
              key: formkey,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Column(
                  children: [
                    const Text(
                      "Change Email",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      autofocus: true,
                      cursorColor: red,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is empty";
                        }

                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: newEmail,
                      decoration: InputDecoration(
                        hintText:
                            "                                                     @gmail.com",
                        focusColor: black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: black)),
                        labelText: "New Email",
                        labelStyle: TextStyle(color: black.withOpacity(0.8)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          child: Text(
                            "Discard",
                            style: TextStyle(color: red, fontSize: 18),
                          ),
                          elevation: 0,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: white,
                          verticalHight: 10,
                          horizontleWidth: 20,
                          circularBorder: 10,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomButton(
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: white),
                          ),
                          elevation: 5,
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await FirebaseAuth.instance.currentUser!
                                  .updateEmail(newEmail.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please Verify your email.")));

                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const VerifyEmail(),
                                  ));
                            }
                          },
                          color: red,
                          verticalHight: 14,
                          horizontleWidth: 40,
                          circularBorder: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

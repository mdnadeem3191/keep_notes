import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:highlark_keep_notes/widget/custom_child.dart';

import '../../const/const.dart';
import 'login_page.dart';

class ForgetPasswordEmailVerification extends StatefulWidget {
  final String email;

  const ForgetPasswordEmailVerification({Key? key, required this.email})
      : super(key: key);

  @override
  State<ForgetPasswordEmailVerification> createState() =>
      _ForgetPasswordEmailVerificationState();
}

class _ForgetPasswordEmailVerificationState
    extends State<ForgetPasswordEmailVerification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final height15 = customHeight / 56.838;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: red,
        elevation: 5,
        title: Text(
          "Email Verication",
          style: TextStyle(fontSize: 20, color: white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "A verification Link has been sent to ${widget.email}. Please check your mail.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: height15 + height10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      child: Text(
                        "Resend Link",
                        style: TextStyle(color: white),
                      ),
                      circularBorder: 10,
                      elevation: 10,
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: widget.email);
                      },
                      color: red,
                      verticalHight: height15,
                      horizontleWidth: width10 * 2),
                  SizedBox(
                    width: width10,
                  ),
                  CustomButton(
                      child: Text(
                        "Back to Login",
                        style: TextStyle(color: white),
                      ),
                      circularBorder: 10,
                      elevation: 10,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      color: red,
                      verticalHight: height15,
                      horizontleWidth: width10 * 2),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/const/const.dart';
import 'package:highlark_keep_notes/screen/firebase/auth_page.dart';
import 'package:highlark_keep_notes/screen/home_page.dart';
import 'package:highlark_keep_notes/widget/custom_child.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    super.initState();

    setState(() {
      Future.delayed(const Duration(seconds: 3), () {
        _reload();
      });
    });
    _startTimer();
  }

  Future _reload() async {
    await FirebaseAuth.instance.currentUser!.reload();
    final isVerifyEmail = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isVerifyEmail) {
      return Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => const HomePage()));
    }
    return _reload();
  }

  int count = 30;
  late Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        count--;
      });
      if (count == 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          "Verify Your Email",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
            child: Text(
              "A verification link has been sent to ${FirebaseAuth.instance.currentUser!.email}.Please check your mail",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  child: Text("Cancel",
                      style: TextStyle(color: red, fontSize: 18)),
                  circularBorder: 0,
                  elevation: 0,
                  onPressed: () {
                    FirebaseAuth.instance.currentUser!.reload();
                    FirebaseAuth.instance.currentUser!.delete();
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const AuthPage(),
                        ));
                  },
                  color: white,
                  verticalHight: 11,
                  horizontleWidth: 30),
              CustomButton(
                  child: Text(
                    count > 0 ? "wait $count sec".toString() : "Resend",
                    style: TextStyle(color: white, fontSize: 15),
                  ),
                  circularBorder: 10,
                  elevation: 10,
                  onPressed: count > 0
                      ? null
                      : () async {
                          await FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          setState(() {
                            timer.cancel();
                            count = 30;
                            _startTimer();
                          });
                        },
                  color: red,
                  verticalHight: 13,
                  horizontleWidth: 20)
            ],
          ),
        ],
      ),
    );
  }
}

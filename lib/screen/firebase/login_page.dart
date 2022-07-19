import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/firebase/create_account.dart';
import 'package:highlark_keep_notes/screen/firebase/verify_email.dart';
import 'package:highlark_keep_notes/services/firestore.dart';

import '../../const/const.dart';
import '../../widget/custom_child.dart';
import '../home_page.dart';
import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showObscure = true;
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42
    bool isPortait = MediaQuery.of(context).orientation == Orientation.portrait;

    final height80 = customHeight / 10.65;
    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width15 = customWidth / 27.42;
    final height12 = customHeight / 71.04;
    final height100 = customHeight / 8.5257;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: red,
              ),
            ),
          )
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: white,
            body: !isPortait
                ? SingleChildScrollView(
                    child: SafeArea(
                        child: Form(
                      key: formkey,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: customWidth / 2,
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: height100 / 2, bottom: height80),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height10, horizontal: width15),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Feild is required";
                                          }
                                          return null;
                                        },
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: red,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintText: "Email",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height10, horizontal: width15),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Feild is required";
                                          }
                                          return null;
                                        },
                                        controller: passwordController,
                                        obscureText: showObscure,
                                        cursorColor: red,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showObscure = !showObscure;
                                              });
                                            },
                                            icon: Icon(
                                              showObscure
                                                  ? Icons.remove_red_eye
                                                  : Icons
                                                      .remove_red_eye_outlined,
                                              color: black.withOpacity(0.7),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: "Password",
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 130,
                                // ),
                              ],
                            ),
                          ),

                          // const Spacer(),
                          Container(
                            width: customWidth / 2,
                            padding: EdgeInsets.only(
                                top: height100 * 2 + height80 / 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width10 * 2),
                                  child: CustomButton(
                                    circularBorder: 25,
                                    elevation: 5,
                                    verticalHight: 12,
                                    horizontleWidth: width10 * 4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                              color: white, fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: width10 * 2,
                                        ),
                                        Icon(
                                          fluent.FluentIcons.signin,
                                          color: white,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                    color: red,
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (formkey.currentState!.validate()) {
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                          if (FirebaseAuth.instance.currentUser!
                                              .emailVerified) {
                                            await FirestoreDB().getAllNotes();
                                            Future.delayed(
                                                const Duration(seconds: 3), () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const HomePage(),
                                                  ));
                                            });
                                          }

                                          return {
                                            await FirebaseAuth
                                                .instance.currentUser!
                                                .sendEmailVerification(),
                                            Navigator.pushReplacement(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const VerifyEmail(),
                                                ))
                                          };
                                        } on FirebaseException catch (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(error.message
                                                      .toString())));
                                        } catch (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(error.toString())));
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: height10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const ForgetPassword(),
                                            ));
                                      },
                                      child: const Text(
                                        "Forget Password?",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    CustomButton(
                                        circularBorder: 25,
                                        child: Text(
                                          "Create an Account",
                                          style: TextStyle(
                                              fontSize: 18, color: red),
                                        ),
                                        elevation: 0,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const CreateAccount(),
                                              ));
                                        },
                                        color: white,
                                        verticalHight: height12,
                                        horizontleWidth: width10),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  )
                : SafeArea(
                    child: Form(
                    key: formkey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    top: height100 / 2, bottom: height80),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                )),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: height10, horizontal: width15),
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Feild is required";
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: red,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Email",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: height10, horizontal: width15),
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Feild is required";
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    obscureText: showObscure,
                                    cursorColor: red,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showObscure = !showObscure;
                                          });
                                        },
                                        icon: Icon(
                                          showObscure
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined,
                                          color: black.withOpacity(0.7),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: "Password",
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(
                            //   height: 130,
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: height10 * 2 + height10,
                        ),
                        // const Spacer(),
                        Container(
                          padding:
                              EdgeInsets.only(bottom: height10 * 2 + height10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width10 * 2),
                                child: CustomButton(
                                  circularBorder: 25,
                                  elevation: 5,
                                  verticalHight: 12,
                                  horizontleWidth: width10 * 7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                            color: white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: width10 * 2,
                                      ),
                                      Icon(
                                        fluent.FluentIcons.signin,
                                        color: white,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                  color: red,
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (FirebaseAuth.instance.currentUser!
                                            .emailVerified) {
                                          await FirestoreDB().getAllNotes();
                                          Future.delayed(
                                              const Duration(seconds: 3), () {
                                            Navigator.pushReplacement(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const HomePage(),
                                                ));
                                          });
                                        } else {
                                          await FirebaseAuth
                                              .instance.currentUser!
                                              .sendEmailVerification();
                                          Navigator.pushReplacement(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const VerifyEmail(),
                                              ));
                                        }
                                      } on FirebaseException catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    error.message.toString())));
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text(error.toString())));
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const ForgetPassword(),
                                          ));
                                    },
                                    child: const Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    width: height10,
                                  ),
                                  CustomButton(
                                      circularBorder: 25,
                                      child: Text(
                                        "Create an Account",
                                        style:
                                            TextStyle(fontSize: 18, color: red),
                                      ),
                                      elevation: 0,
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const CreateAccount(),
                                            ));
                                      },
                                      color: white,
                                      verticalHight: height12,
                                      horizontleWidth: width10),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
          );
  }
}

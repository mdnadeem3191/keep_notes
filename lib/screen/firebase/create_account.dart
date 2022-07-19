import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/firebase/verify_email.dart';
import 'package:highlark_keep_notes/services/firestore.dart';

import '../../const/const.dart';
import '../../widget/custom_child.dart';

import 'login_page.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool isObscure = true;
  bool isLoading = false;

  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width;
    bool isPotrait =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final height80 = customHeight / 10.65;
    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width15 = customWidth / 27.42;
    final height12 = customHeight / 71.04;
    final height100 = customHeight / 8.5257;

    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: red,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: white,
            body: isPotrait
                ? SingleChildScrollView(
                    child: SafeArea(
                        child: Form(
                      key: formkey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: customWidth / 2,
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        top: height100 / 2, bottom: height80),
                                    child: const Text(
                                      "Create an Account",
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
                                            return "Field is required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        autofocus: false,
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
                                        cursorColor: red,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: "Full Name",
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
                                            return "Field is required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        autofocus: false,
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: red,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                            return "Field is required";
                                          } else if (value.length < 6) {
                                            return "Password should be atleast 6 character";
                                          } else if (value.isNotEmpty !=
                                              passwordController.text.contains(
                                                  RegExp(
                                                      "(?:[^a-z]*[a-z]){1}"))) {
                                            return "Atleast one Lower Case";
                                          } else if (value.isNotEmpty !=
                                              passwordController.text.contains(
                                                  RegExp(
                                                      "(?:[^A-Z]*[A-Z]){1}"))) {
                                            return "Atleast one Upper Case";
                                          } else if (value.isNotEmpty !=
                                              passwordController.text
                                                  .contains(RegExp('[0-9]'))) {
                                            return "Atleast one number";
                                          } else if (value.isNotEmpty !=
                                              passwordController.text.contains(
                                                  RegExp(
                                                      r'[!@#$%^&*(),.?":{}|<>]'))) {
                                            return "Atleast one special character like @,\$,#...";
                                          } else if (passwordController.text !=
                                              confirmPasswordController.text) {
                                            return "Password does not match";
                                          }
                                          return null;
                                        },
                                        controller: passwordController,
                                        obscureText: true,
                                        cursorColor: red,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: "Password",
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
                                            return "Field is required";
                                          } else if (value.length < 6) {
                                            return "Password should be atleast 6 character";
                                          } else if (value.isNotEmpty !=
                                              confirmPasswordController.text
                                                  .contains(RegExp(
                                                      "(?:[^a-z]*[a-z]){1}"))) {
                                            return "Atleast one Lower Case";
                                          } else if (value.isNotEmpty !=
                                              confirmPasswordController.text
                                                  .contains(RegExp(
                                                      "(?:[^A-Z]*[A-Z]){1}"))) {
                                            return "Atleast one Upper Case";
                                          } else if (value.isNotEmpty !=
                                              confirmPasswordController.text
                                                  .contains(RegExp('[0-9]'))) {
                                            return "Atleast one number";
                                          } else if (value.isNotEmpty !=
                                              confirmPasswordController.text
                                                  .contains(RegExp(
                                                      r'[!@#$%^&*(),.?":{}|<>]'))) {
                                            return "Atleast one special character like @,\$,#...";
                                          } else if (confirmPasswordController
                                                  .text !=
                                              passwordController.text) {
                                            return "Password does not match";
                                          }
                                          return null;
                                        },
                                        controller: confirmPasswordController,
                                        obscureText: isObscure,
                                        cursorColor: red,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isObscure = !isObscure;
                                                });
                                              },
                                              icon: Icon(
                                                isObscure
                                                    ? Icons.remove_red_eye
                                                    : Icons
                                                        .remove_red_eye_outlined,
                                                color: black.withOpacity(0.8),
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: "Confirm Password",
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
                                          "Register",
                                          style: TextStyle(
                                              color: white, fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: width10 * 2,
                                        ),
                                        Icon(
                                          fluent.FluentIcons.people_add,
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
                                              .createUserWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await FirestoreDB().createName(
                                              nameController
                                                  .text); // name store
                                          FirebaseAuth.instance.currentUser!
                                              .sendEmailVerification();

                                          Navigator.pushReplacement(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const VerifyEmail(),
                                              ));
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
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                    circularBorder: 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an Account?",
                                          style: TextStyle(
                                              color: black, fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: width10 / 2,
                                        ),
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 17, color: red),
                                        )
                                      ],
                                    ),
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ));
                                    },
                                    color: white,
                                    verticalHight: height12,
                                    horizontleWidth: width10)
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: height100 / 2, bottom: height80),
                                  child: const Text(
                                    "Create an Account",
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
                                          return "Field is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      autofocus: false,
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                      cursorColor: red,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Full Name",
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
                                          return "Field is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      autofocus: false,
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: red,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                          return "Field is required";
                                        } else if (value.length < 6) {
                                          return "Password should be atleast 6 character";
                                        } else if (value.isNotEmpty !=
                                            passwordController.text.contains(
                                                RegExp(
                                                    "(?:[^a-z]*[a-z]){1}"))) {
                                          return "Atleast one Lower Case";
                                        } else if (value.isNotEmpty !=
                                            passwordController.text.contains(
                                                RegExp(
                                                    "(?:[^A-Z]*[A-Z]){1}"))) {
                                          return "Atleast one Upper Case";
                                        } else if (value.isNotEmpty !=
                                            passwordController.text
                                                .contains(RegExp('[0-9]'))) {
                                          return "Atleast one number";
                                        } else if (value.isNotEmpty !=
                                            passwordController.text.contains(
                                                RegExp(
                                                    r'[!@#$%^&*(),.?":{}|<>]'))) {
                                          return "Atleast one special character like @,\$,#...";
                                        } else if (passwordController.text !=
                                            confirmPasswordController.text) {
                                          return "Password does not match";
                                        }
                                        return null;
                                      },
                                      controller: passwordController,
                                      obscureText: true,
                                      cursorColor: red,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Password",
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
                                          return "Field is required";
                                        } else if (value.length < 6) {
                                          return "Password should be atleast 6 character";
                                        } else if (value.isNotEmpty !=
                                            confirmPasswordController.text
                                                .contains(RegExp(
                                                    "(?:[^a-z]*[a-z]){1}"))) {
                                          return "Atleast one Lower Case";
                                        } else if (value.isNotEmpty !=
                                            confirmPasswordController.text
                                                .contains(RegExp(
                                                    "(?:[^A-Z]*[A-Z]){1}"))) {
                                          return "Atleast one Upper Case";
                                        } else if (value.isNotEmpty !=
                                            confirmPasswordController.text
                                                .contains(RegExp('[0-9]'))) {
                                          return "Atleast one number";
                                        } else if (value.isNotEmpty !=
                                            confirmPasswordController.text
                                                .contains(RegExp(
                                                    r'[!@#$%^&*(),.?":{}|<>]'))) {
                                          return "Atleast one special character like @,\$,#...";
                                        } else if (confirmPasswordController
                                                .text !=
                                            passwordController.text) {
                                          return "Password does not match";
                                        }
                                        return null;
                                      },
                                      controller: confirmPasswordController,
                                      obscureText: isObscure,
                                      cursorColor: red,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isObscure = !isObscure;
                                              });
                                            },
                                            icon: Icon(
                                              isObscure
                                                  ? Icons.remove_red_eye
                                                  : Icons
                                                      .remove_red_eye_outlined,
                                              color: black.withOpacity(0.8),
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Confirm Password",
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
                          // const Spacer(),
                          SizedBox(
                            height: height10 * 2 + height10,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: height10 * 2 + height10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Register",
                                          style: TextStyle(
                                              color: white, fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: width10 * 2,
                                        ),
                                        Icon(
                                          fluent.FluentIcons.people_add,
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
                                              .createUserWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await FirestoreDB()
                                              .createName(nameController.text);
                                          FirebaseAuth.instance.currentUser!
                                              .sendEmailVerification();

                                          Navigator.pushReplacement(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const VerifyEmail(),
                                              ));
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
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                    circularBorder: 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an Account?",
                                          style: TextStyle(
                                              color: black, fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: width10 / 2,
                                        ),
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 17, color: red),
                                        )
                                      ],
                                    ),
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ));
                                    },
                                    color: white,
                                    verticalHight: height12,
                                    horizontleWidth: width10)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
          );
  }
}

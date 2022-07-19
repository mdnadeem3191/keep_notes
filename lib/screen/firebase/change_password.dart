import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/account.dart';
import 'package:highlark_keep_notes/widget/custom_child.dart';

import '../../const/const.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  bool isObscure = true;

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width15 = customWidth / 27.42;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          "Notekeeper",
          style: TextStyle(color: black, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
      ),
      body: isPortrait
          ? SingleChildScrollView(
              child: SafeArea(
                  child: Form(
                      key: formkey,
                      child: SafeArea(
                        child: Row(
                          children: [
                            Container(
                              width: customWidth / 2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: width15, vertical: height10 * 2),
                              child: Column(
                                children: [
                                  const Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: height10 * 2.5,
                                  ),
                                  TextFormField(
                                    cursorColor: red,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password is empty";
                                      }
                                      // else if(){}
                                      return null;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: oldPassword,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black)),
                                        labelStyle: TextStyle(
                                            color: black.withOpacity(0.7)),
                                        labelText: "Old Password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    cursorColor: red,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (value.length < 6) {
                                        return "Password should be atleast 6 character";
                                      } else if (value.isNotEmpty !=
                                          newPassword.text.contains(
                                              RegExp("(?:[^a-z]*[a-z]){1}"))) {
                                        return "Atleast one Lower Case";
                                      } else if (value.isNotEmpty !=
                                          newPassword.text.contains(
                                              RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                                        return "Atleast one Upper Case";
                                      } else if (value.isNotEmpty !=
                                          newPassword.text
                                              .contains(RegExp('[0-9]'))) {
                                        return "Atleast one number";
                                      } else if (value.isNotEmpty !=
                                          newPassword.text.contains(RegExp(
                                              r'[!@#$%^&*(),.?":{}|<>]'))) {
                                        return "Atleast one special character like @,\$,#...";
                                      } else if (newPassword.text !=
                                          confirmNewPassword.text) {
                                        return "Password does not match";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: newPassword,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: black)),
                                        labelStyle: TextStyle(
                                            color: black.withOpacity(0.7)),
                                        labelText: "New password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    cursorColor: red,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (value.length < 6) {
                                        return "Password should be atleast 6 character";
                                      } else if (value.isNotEmpty !=
                                          confirmNewPassword.text.contains(
                                              RegExp("(?:[^a-z]*[a-z]){1}"))) {
                                        return "Atleast one Lower Case";
                                      } else if (value.isNotEmpty !=
                                          confirmNewPassword.text.contains(
                                              RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                                        return "Atleast one Upper Case";
                                      } else if (value.isNotEmpty !=
                                          confirmNewPassword.text
                                              .contains(RegExp('[0-9]'))) {
                                        return "Atleast one number";
                                      } else if (value.isNotEmpty !=
                                          confirmNewPassword.text.contains(
                                              RegExp(
                                                  r'[!@#$%^&*(),.?":{}|<>]'))) {
                                        return "Atleast one special character like @,\$,#...";
                                      } else if (confirmNewPassword.text !=
                                          newPassword.text) {
                                        return "Password does not match";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: confirmNewPassword,
                                    obscureText: isObscure,
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
                                        labelStyle: TextStyle(
                                            color: black.withOpacity(0.7)),
                                        labelText: "Confirm Password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: customWidth / 2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: width15, vertical: height10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    child: Text(
                                      "Discard",
                                      style:
                                          TextStyle(color: red, fontSize: 18),
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
                                        var credential =
                                            EmailAuthProvider.credential(
                                          email: FirebaseAuth
                                              .instance.currentUser!.email!,
                                          password: oldPassword.text,
                                        );

                                        try {
                                          await FirebaseAuth
                                              .instance.currentUser!
                                              .reauthenticateWithCredential(
                                                  credential);
                                          await FirebaseAuth
                                              .instance.currentUser!
                                              .updatePassword(newPassword.text);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Your Password has been changed.")));

                                          Navigator.pushReplacement(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const Account(),
                                              ));
                                        } on FirebaseException catch (_) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Old password is incorrect")));
                                        } catch (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(error.toString())));
                                        }
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
                      ))),
            )
          : SafeArea(
              child: Form(
                key: formkey,
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width15 + width10, vertical: height10 * 2),
                    child: Column(
                      children: [
                        const Text(
                          "Change Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                        SizedBox(
                          height: height10 * 2.5,
                        ),
                        TextFormField(
                          cursorColor: red,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is empty";
                            }
                            // else if(){}
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: oldPassword,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: black)),
                              labelStyle:
                                  TextStyle(color: black.withOpacity(0.7)),
                              labelText: "Old Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: red,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field is required";
                            } else if (value.length < 6) {
                              return "Password should be atleast 6 character";
                            } else if (value.isNotEmpty !=
                                newPassword.text
                                    .contains(RegExp("(?:[^a-z]*[a-z]){1}"))) {
                              return "Atleast one Lower Case";
                            } else if (value.isNotEmpty !=
                                newPassword.text
                                    .contains(RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                              return "Atleast one Upper Case";
                            } else if (value.isNotEmpty !=
                                newPassword.text.contains(RegExp('[0-9]'))) {
                              return "Atleast one number";
                            } else if (value.isNotEmpty !=
                                newPassword.text.contains(
                                    RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return "Atleast one special character like @,\$,#...";
                            } else if (newPassword.text !=
                                confirmNewPassword.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: newPassword,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: black)),
                              labelStyle:
                                  TextStyle(color: black.withOpacity(0.7)),
                              labelText: "New password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: red,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field is required";
                            } else if (value.length < 6) {
                              return "Password should be atleast 6 character";
                            } else if (value.isNotEmpty !=
                                confirmNewPassword.text
                                    .contains(RegExp("(?:[^a-z]*[a-z]){1}"))) {
                              return "Atleast one Lower Case";
                            } else if (value.isNotEmpty !=
                                confirmNewPassword.text
                                    .contains(RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                              return "Atleast one Upper Case";
                            } else if (value.isNotEmpty !=
                                confirmNewPassword.text
                                    .contains(RegExp('[0-9]'))) {
                              return "Atleast one number";
                            } else if (value.isNotEmpty !=
                                confirmNewPassword.text.contains(
                                    RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return "Atleast one special character like @,\$,#...";
                            } else if (confirmNewPassword.text !=
                                newPassword.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: confirmNewPassword,
                          obscureText: isObscure,
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
                                        : Icons.remove_red_eye_outlined,
                                    color: black.withOpacity(0.8),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: black)),
                              labelStyle:
                                  TextStyle(color: black.withOpacity(0.7)),
                              labelText: "Confirm Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
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
                                  var credential = EmailAuthProvider.credential(
                                    email: FirebaseAuth
                                        .instance.currentUser!.email!,
                                    password: oldPassword.text,
                                  );

                                  try {
                                    await FirebaseAuth.instance.currentUser!
                                        .reauthenticateWithCredential(
                                            credential);
                                    await FirebaseAuth.instance.currentUser!
                                        .updatePassword(newPassword.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Your Password has been changed.")));

                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => const Account(),
                                        ));
                                  } on FirebaseException catch (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Old password is incorrect")));
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(error.toString())));
                                  }
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
              ),
            ),
    );
  }
}

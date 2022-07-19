import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/const/const.dart';
import 'package:highlark_keep_notes/widget/custom_child.dart';

class HelpFeedback extends StatelessWidget {
  const HelpFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help & Feedback",
          style: TextStyle(fontSize: 19),
        ),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(left: width10, right: width10, top: height10 * 5),
          child: Column(
            children: [
              TextField(
                maxLines: 8,
                minLines: null,
                cursorColor: red,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Please give feedback & suggestion",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  child: Text(
                    "Send Feedback",
                    style: TextStyle(color: white),
                  ),
                  circularBorder: 10,
                  elevation: 10,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpFeedback(),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Your feedback has been submitted")));
                  },
                  color: red,
                  verticalHight: 13,
                  horizontleWidth: 25)
            ],
          ),
        ),
      ),
    );
  }
}

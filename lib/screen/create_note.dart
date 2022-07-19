import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/model/notes_model.dart';
import 'package:highlark_keep_notes/services/sqflite_db.dart';
import 'package:uuid/uuid.dart';

import '../const/const.dart';
import 'home_page.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  bool pinData = false;
  bool archiveData = false;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final width12 = customWidth / 34.25;

    return WillPopScope(
      onWillPop: () async {
        if (title.text.isNotEmpty || content.text.isNotEmpty) {
          await NotesDataBase.instance.insertData(
            Notes(
              uniqueId: uuid.v1(),
              title: title.text,
              content: content.text,
              pin: pinData,
              isArchive: archiveData,
              createTime: DateTime.now(),
            ),
          );
        }

        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomePage(),
          ),
        );

        return false;
        // );//  true false kya hai isme?//
      },
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (title.text.isNotEmpty || content.text.isNotEmpty) {
                          await NotesDataBase.instance.insertData(
                            Notes(
                              uniqueId: uuid.v1(),
                              title: title.text,
                              content: content.text,
                              pin: pinData,
                              isArchive: archiveData,
                              createTime: DateTime.now(),
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                        // Navigator.pushReplacement(
                        //   context,
                        //   CupertinoPageRoute(
                        //     builder: (context) => const HomePage(),
                        //   ),
                        // );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: black.withOpacity(0.7),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              pinData = !pinData;
                            });
                          },
                          icon: Icon(
                            pinData
                                ? Icons.push_pin_rounded
                                : Icons.push_pin_outlined,
                            color: black.withOpacity(0.7),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              archiveData = !archiveData;
                            });
                          },
                          icon: Icon(
                            archiveData
                                ? Icons.archive
                                : Icons.archive_outlined,
                            color: black.withOpacity(0.7),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width12),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 23,
                        color: black,
                        fontWeight: FontWeight.w500),
                    controller: title,
                    cursorColor: black,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 23,
                            color: black.withOpacity(0.6),
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width12),
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    maxLines: null,
                    minLines: 100,
                    cursorColor: black,
                    controller: content,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "content",
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

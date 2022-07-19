import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/model/notes_model.dart';
import 'package:highlark_keep_notes/services/sqflite_db.dart';
import 'package:intl/intl.dart';

import '../const/const.dart';
import 'home_page.dart';

class MainNoteView extends StatefulWidget {
  final Notes notes;

  const MainNoteView({Key? key, required this.notes}) : super(key: key);
  @override
  State<MainNoteView> createState() => _MainNoteViewState();
}

class _MainNoteViewState extends State<MainNoteView> {
  late String newTitle;
  late String newContent;

  late bool pinData;
  late bool archiveData;

  @override
  void initState() {
    super.initState();
    newTitle = widget.notes.title.toString();
    newContent = widget.notes.content.toString();

    pinData = widget.notes.pin;
    archiveData = widget.notes.isArchive;
  }

  @override
  Widget build(BuildContext context) {
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final width12 = customWidth / 34.25;

    return WillPopScope(
      onWillPop: () async {
        Notes updateNotes = Notes(
            uniqueId: widget.notes.uniqueId,
            title: newTitle,
            content: newContent,
            pin: pinData,
            isArchive: archiveData,
            createTime: DateTime.now(),
            id: widget.notes.id);
        await NotesDataBase.instance.updateNote(updateNotes);
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => const HomePage(),
            ));
        return false; //  true false kya hai isme?//
      },
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          Notes updateNotes = Notes(
                              uniqueId: widget.notes.uniqueId,
                              title: newTitle,
                              content: newContent,
                              pin: pinData,
                              isArchive: archiveData,
                              createTime: widget.notes.title != newTitle ||
                                      widget.notes.content != newContent
                                  ? DateTime.now()
                                  : widget.notes.createTime,
                              id: widget.notes.id);
                          await NotesDataBase.instance.updateNote(updateNotes);
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const HomePage(),
                              ));
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
                            onPressed: () async {
                              await NotesDataBase.instance
                                  .deleteNote(widget.notes);
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const HomePage(),
                                  ));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: black.withOpacity(0.7),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: customWidth,
                    height: 725,
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width12),
                          child: Form(
                            child: TextFormField(
                              onChanged: (value) {
                                newTitle = value;
                              },
                              initialValue: newTitle,
                              style: TextStyle(
                                  fontSize: 23,
                                  color: black,
                                  fontWeight: FontWeight.w500),
                              // controller: title,
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
                                      color: black.withOpacity(0.8),
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width12),
                          child: Form(
                            child: TextFormField(
                              onChanged: (value) {
                                newContent = value;
                              },
                              initialValue: newContent,
                              style: TextStyle(
                                  fontSize: 18, color: black.withOpacity(0.8)),
                              maxLines: null,
                              minLines: 100,
                              cursorColor: black,
                              // controller: content,
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
                          ),
                        ),
                      ],
                    ), // '${timeFormat.format DateTime.now())}'
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.color_lens_outlined)),
                        const SizedBox(
                          width: 100,
                        ),
                        Text(
                          "Edited ${DateFormat("kk:mm a").format(widget.notes.createTime)}",
                          style: TextStyle(
                              fontSize: 14, color: black.withOpacity(0.8)),
                        ), //DateFormat('yyyy-MM-dd – kk:mm').format(now);
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

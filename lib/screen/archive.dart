import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/screen/search_notes.dart';
import 'package:highlark_keep_notes/services/sqflite_db.dart';
import 'package:jiffy/jiffy.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../const/const.dart';
import '../model/notes_model.dart';
import 'drawer.dart';
import 'archive_view.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List<Notes> archiveList = [];
  bool isGridview = true;

  @override
  void initState() {
    super.initState();
    readArchiveData();
  }

  Future readArchiveData() async {
    archiveList = await NotesDataBase.instance.readArchiveData();
    setState(() {
      archiveList;
    });
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height50 = customHeight / 17.05;
    final width100 = customWidth / 4.1142;
    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width15 = customWidth / 26.18;

    return WillPopScope(
      onWillPop: () async {
        bool willPop = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Confirm",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                content: const Text(
                  "Do you want to exit",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: black, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: red, fontSize: 17),
                    ),
                  )
                ],
              );
            });
        return Future.value(willPop);
      },
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: true,
        drawer: const MyDrawer(),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: width15,
                    right: width15,
                    bottom: height10,
                    top: height10),
                padding: EdgeInsets.symmetric(horizontal: width10 / 2),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                      color: black.withOpacity(0.8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const SearchNotes(),
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 13,
                        ),
                        height: height50,
                        width: width100 * 2 + width15 * 2,
                        child: const Text(
                          "Search your notes",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => black.withOpacity(0.1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ))),
                        onPressed: () {
                          setState(() {
                            isGridview = !isGridview;
                          });
                        },
                        child: Icon(
                          isGridview
                              ? Icons.view_stream_outlined
                              : Icons.grid_view,
                          color: black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isGridview
                  ? StaggeredView(
                      text: "Archived",
                      notesList: archiveList,
                      readArchiveData: readArchiveData(),
                    )
                  : ListViews(
                      text: "Archived",
                      notesList: archiveList,
                      readArchiveData: readArchiveData(),
                    ),
            ],
          )),
        ),
      ),
    );
  }
}

class StaggeredView extends StatelessWidget {
  const StaggeredView(
      {Key? key,
      required this.readArchiveData,
      required this.notesList,
      required this.text})
      : super(key: key);

  final List<Notes> notesList;
  final String text;
  final Future readArchiveData;

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height10 = customHeight / 85.257;
    final width15 = customWidth / 26.18;
    final width12 = customWidth / 34.25;
    final height12 = customHeight / 71.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: width15, vertical: height10),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width12, vertical: height10),
          child: StaggeredGridView.countBuilder(
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            crossAxisCount: 4,
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
            itemCount: notesList.length,
            itemBuilder: (context, index) => InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ArchiveNoteView(
                        notes: notesList[index],
                      ),
                    )).then((value) {
                  readArchiveData;
                });
              },
              child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width12, vertical: height12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: grey)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notesList[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          notesList[index].content.length > 250
                              ? notesList[index].content.substring(0, 250)
                              : notesList[index].content,
                          style: TextStyle(
                              fontSize: 16, color: black.withOpacity(0.7)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Jiffy(notesList[index].createTime).yMMMMd,
                              style: TextStyle(
                                  fontSize: 14, color: black.withOpacity(0.5)),
                            ),
                          ],
                        )
                      ])),
            ),
          ),
        ),
      ],
    );
  }
}

class ListViews extends StatelessWidget {
  const ListViews(
      {Key? key,
      required this.notesList,
      required this.readArchiveData,
      required this.text})
      : super(key: key);

  final List<Notes> notesList;
  final String text;
  final Future readArchiveData;

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height10 = customHeight / 85.257;
    final height15 = customHeight / 56.838;
    final width12 = customWidth / 34.25;
    final height12 = customHeight / 71.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: width12, vertical: height15),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width12, vertical: height10),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: notesList.length,
            itemBuilder: (context, index) => InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ArchiveNoteView(
                          notes: notesList[index],
                        ),
                      )).then((value) {
                    readArchiveData;
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width12, vertical: height12),
                    margin: EdgeInsets.symmetric(vertical: height10 / 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: grey)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notesList[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            notesList[index].content.length > 250
                                ? notesList[index].content.substring(0, 250)
                                : notesList[index].content,
                            style: TextStyle(
                                fontSize: 16, color: black.withOpacity(0.7)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Jiffy(notesList[index].createTime).yMMMMd,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black.withOpacity(0.5)),
                              ),
                            ],
                          )
                        ]))),
          ),
        ),
      ],
    );
  }
}

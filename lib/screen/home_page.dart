import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlark_keep_notes/model/notes_model.dart';
import 'package:highlark_keep_notes/screen/search_notes.dart';
import 'package:highlark_keep_notes/services/sqflite_db.dart';
import 'package:jiffy/jiffy.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../const/const.dart';
import 'create_note.dart';
import 'drawer.dart';
import 'main_note_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Notes> notesList = [];
  List<Notes> pinList = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isGridview = true;
  bool hideTitleBar = true;
  bool seekSearchBar = false;

  @override
  void initState() {
    super.initState();

    hide();
    seek();
    readAllData();
    readPinData();

    
  }

  Future readAllData() async {
    notesList = await NotesDataBase.instance.readAllData();
    setState(() {
      notesList;
    });
  }

  Future readPinData() async {
    pinList = await NotesDataBase.instance.readPinData();
    setState(() {
      pinList;
    });
  }

  hide() async {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        hideTitleBar = false;
      });
    });
  }

  seek() async {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        seekSearchBar = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final height100 = customHeight / 8.5257;
    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width15 = customWidth / 27.42;

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
        floatingActionButton: FloatingActionButton(
            backgroundColor: white,
            splashColor: black.withOpacity(0.2),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const CreateNote(),
                ),
              ).then((value) {
                readAllData();
                readPinData();
              });
            },
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 193, 29, 17),
            )),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: isPortrait
              ? SafeArea(
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
                        color: grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            icon: const Icon(Icons.menu),
                            color: black.withOpacity(0.8),
                          ),
                          if (hideTitleBar == true)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const SearchNotes(),
                                    ));
                              },
                              child: SizedBox(
                                height: 200,
                                width: width10 * 18,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 100,
                                      child: Image.asset(
                                        "images/2.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Keep",
                                      style: TextStyle(
                                        color: black.withOpacity(0.8),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (seekSearchBar == true)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const SearchNotes(),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: customHeight / 65.58,
                                ),
                                height: height100 / 2,
                                width: 650,
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
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
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
                    if (pinList.isNotEmpty)
                      isGridview
                          ? StaggeredView(
                              text: "Pinned",
                              notesList: pinList,
                            )
                          : ListViews(
                              text: "Pinned",
                              notesList: pinList,
                            ),
                    isGridview
                        ? StaggeredView(
                            text: pinList.isEmpty ? "All" : "Others",
                            notesList: notesList,
                          )
                        : ListViews(
                            text: pinList.isEmpty ? "All" : "Others",
                            notesList: notesList,
                          ),
                  ],
                ))
              : SafeArea(
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
                        color: grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            icon: const Icon(Icons.menu),
                            color: black.withOpacity(0.8),
                          ),
                          if (hideTitleBar == true)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const SearchNotes(),
                                    ));
                              },
                              child: SizedBox(
                                height: 200,
                                width: width10 * 18,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 100,
                                      child: Image.asset(
                                        "images/2.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Keep",
                                      style: TextStyle(
                                        color: black.withOpacity(0.8),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (seekSearchBar == true)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const SearchNotes(),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: customHeight / 65.58,
                                ),
                                height: height100 / 2,
                                width: customWidth / 1.60085,
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
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
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
                    if (pinList.isNotEmpty)
                      isGridview
                          ? StaggeredView(
                              text: "Pinned",
                              notesList: pinList,
                            )
                          : ListViews(
                              text: "Pinned",
                              notesList: pinList,
                            ),
                    isGridview
                        ? StaggeredView(
                            text: pinList.isEmpty ? "All" : "Others",
                            notesList: notesList,
                          )
                        : ListViews(
                            text: pinList.isEmpty ? "All" : "Others",
                            notesList: notesList,
                          ),
                  ],
                )),
        ),
      ),
    );
  }
}

class StaggeredView extends StatelessWidget {
  const StaggeredView({Key? key, required this.notesList, required this.text})
      : super(key: key);

  final List<Notes> notesList;
  final String text;

  @override
  Widget build(BuildContext context) {
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final width15 = customWidth / 26.18;
    final width12 = customWidth / 34.25;

    return notesList.isEmpty 
        ? Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: width15 * 5),
              child: Column(
                children: [
                  Image.asset(
                    "images/251.png",
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "No notes here",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Tap ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.note_add_outlined,
                        size: 22,
                      ),
                      Text(
                        " to create a new one",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: width15, vertical: 10),
                child: Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: customWidth / 34.25, vertical: 10),
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
                            builder: (context) => MainNoteView(
                              notes: notesList[index],
                            ),
                          ));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width12, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notesList[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 19),
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
                                //Jiffy().format("yyyy-MM-dd HH:mm:ss");
                                //Jiffy(DateTime(2019, 10, 18)).yMMMMd;
                                Text(
                                  Jiffy(notesList[index].createTime).yMMMMd,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: black.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          );
  }
}

class ListViews extends StatelessWidget {
  const ListViews({Key? key, required this.notesList, required this.text})
      : super(key: key);

  final List<Notes> notesList;
  final String text;

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height10 = customHeight / 85.257;
    final width15 = customWidth / 26.18;
    final width12 = customWidth / 34.25;

    return notesList.isEmpty
        ? Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: width15 * 5),
              child: Column(
                children: [
                  Image.asset(
                    "images/251.png",
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "No notes here",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Tap ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.note_add_outlined,
                        size: 22,
                      ),
                      Text(
                        " to create a new one",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width15, vertical: height10),
                child: Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width12, vertical: 10),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notesList.length,
                  itemBuilder: (context, index) => InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => MainNoteView(
                              notes: notesList[index],
                            ),
                          ));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width12, vertical: 12),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notesList[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 19),
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
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          );
  }
}

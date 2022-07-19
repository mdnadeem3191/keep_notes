import 'package:flutter/material.dart';
import '../const/const.dart';

class SearchNotes extends StatefulWidget {
  const SearchNotes({Key? key}) : super(key: key);

  @override
  State<SearchNotes> createState() => _SearchNotesState();
}

class _SearchNotesState extends State<SearchNotes> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height; //852.57
    double customWidth = MediaQuery.of(context).size.width; //411.42

    final height50 = customHeight / 17.05;
    final width100 = customWidth / 4.1142;
    final height10 = customHeight / 85.257;
    final width10 = customWidth / 41.142;
    final width15 = customWidth / 27.42;

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: width15,
                    right: width15,
                    bottom: height10,
                    top: height10),
                padding: EdgeInsets.symmetric(horizontal: width10 / 2),
                height: height50,
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: black.withOpacity(0.8),
                    ),
                    SizedBox(
                        height: 50,
                        width: 240,
                        child: TextField(
                          cursorColor: black.withOpacity(0.1),
                          controller: searchController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search your notes"),
                        )),
                    SizedBox(
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => black.withOpacity(0.1)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ))),
                        onPressed: () {},
                        child: Icon(
                          Icons.search,
                          color: black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width100 * 2 + width100 / 2,
              ),
              Text(
                "Under Maintenance",
                style: TextStyle(
                    color: black, fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}

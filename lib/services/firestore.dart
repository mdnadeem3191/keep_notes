import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:highlark_keep_notes/model/notes_model.dart';
import 'package:highlark_keep_notes/services/sqflite_db.dart';

class FirestoreDB {
  createNewNotesFirestore(Notes notes) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .collection("UserNotes")
        .doc(notes.uniqueId)
        .set({
      "uniqueId": notes.uniqueId,
      "title": notes.title,
      "content": notes.content,
      "date": notes.createTime,
    });
  }

  getAllNotes() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .collection("UserNotes")
        .orderBy("date")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Map note = result.data();

        NotesDataBase.instance.insertData(
          Notes(
            title: note["title"],
            uniqueId: note["uniqueId"],
            content: note["content"],
            pin: false,
            isArchive: false,
            createTime: note["date"].toDate(),
          ),
        );
      });
    });
  }

  updateNotes(Notes notes) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .collection("UserNotes")
        .doc(notes.uniqueId)
        .update({"title": notes.title, "content": notes.content});
  }

  deleteNotes(Notes notes) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .collection("UserNotes")
        .doc(notes.uniqueId)
        .delete();
  }

  createName(String name) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .collection("User")
        .doc(currentUser.email)
        .set({"name": name});
  }

  getName() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .collection("User")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.map((document) {
        Map name = document.data();
        return name["name"];
      });
    });
  }

  updateName(String name) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .collection("User")
        .doc(currentUser.email)
        .update({"name": name});
  }

  deleteAllNotes() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Notes")
        .doc(currentUser!.email)
        .delete();
  }
}

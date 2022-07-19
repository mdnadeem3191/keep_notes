import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:highlark_keep_notes/screen/firebase/auth_page.dart';
import 'package:highlark_keep_notes/screen/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // status bar color(white)
      statusBarIconBrightness:
          Brightness.dark, //status bar icon color(black) like date,wifi,battery
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notekeeper",
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const AuthPage()
          : !FirebaseAuth.instance.currentUser!.emailVerified
              ? const AuthPage()
              : const HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        // visualDensity: VisualDensity.adaptivePlatformDensity
        //  brightness: Brightness.dark,
      ),
    );
  }
}

//Now app is completed.

//what i do in future:-
// color show in app;
//sync on/of;
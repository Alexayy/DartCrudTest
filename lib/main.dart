import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _create() async {
    try {
      await firestore.collection("users").doc("testUser").set({
        'firstName' : 'test',
        'lastName' : 'user',
      });
    } catch(e) {
      print(e);
    }
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection("users").doc("testUser").get();
      print(documentSnapshot.data());
    } catch(e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore.collection("users").doc("testUser").update({
        'firstName' : 'Test Updated',
      });
    } catch(e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection("users").doc("testUser").delete();
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            child: Text("Create"),
              onPressed: _create
          ),
          ElevatedButton(
              child: Text("Read"),
              onPressed: _read
          ),
          ElevatedButton(
              child: Text("Update"),
              onPressed: _update
          ),
          ElevatedButton(
              child: Text("Delete"),
              onPressed: _delete
          )
        ],),
      ),
    );
  }
}



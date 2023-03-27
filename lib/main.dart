import 'package:flutter/material.dart';
import 'package:todo_list/pages/home.dart';
import 'package:todo_list/pages/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/todo': (context) => Home()
    },
  ));
}
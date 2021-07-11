import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ms_project/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp();
  runApp(App());
}

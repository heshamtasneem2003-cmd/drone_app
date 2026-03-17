import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project/core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DorounApp());
}

class DorounApp extends StatelessWidget {
  const DorounApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppWidget();
  }
}

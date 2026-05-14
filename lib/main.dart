import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:graduation_project/core/app.dart';
import 'package:graduation_project/features/auth/presentation/form_page.dart';
import 'package:graduation_project/features/home/presentation/home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DorounApp());
}

class DorounApp extends StatelessWidget {
  const DorounApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          
          if (snapshot.hasData) {
            return const FormPage(); 
          }
          
          return const AppWidget(); 
        },
      ),
    );
  }
}
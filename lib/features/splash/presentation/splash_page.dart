import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:graduation_project/features/auth/presentation/login_page.dart';
import 'package:graduation_project/features/home/presentation/home_page.dart'; 

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        title: const Text(''), 
        backgroundColor: const Color(0xff76545D), 
        elevation: 0,
      ), 
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 112,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('images/Doroun.png'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Drone',
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 52, 93),
                  fontSize: 32,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Color(0xff6C8090),
                thickness: 1,
                indent: 38,
                endIndent: 38,
                height: 8,
              ),
              const SizedBox(height: 20),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () {
                    
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF4BBBB), 
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 65,
                    width: 200,
                    alignment: Alignment.center,
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 150),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () {
                    debugPrint('Emergency Call Pressed');
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 61, 61),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 65,
                    width: 250,
                    child: const Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone, size: 32, color: Color.fromARGB(255, 229, 243, 255)),
                            SizedBox(width: 12),
                            Text(
                              'Emergency Call',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
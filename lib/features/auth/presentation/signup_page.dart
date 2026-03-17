import 'package:flutter/material.dart';
import 'package:graduation_project/features/home/presentation/home_page.dart';
import 'package:graduation_project/widgets/auth_text_field.dart';
import 'package:graduation_project/widgets/action_button.dart';
import 'package:graduation_project/widgets/emergency_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Color(0xff76545D),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const AuthTextField(label: 'First Name', icon: Icons.person),
              const SizedBox(height: 15),
              const AuthTextField(label: 'Last Name', icon: Icons.person),
              const SizedBox(height: 15),
              const AuthTextField(
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              const AuthTextField(
                label: 'Confirm Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              const AuthTextField(label: 'Email', icon: Icons.email),
              const SizedBox(height: 20),

              ActionButton(
                label: 'Sign up',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              const SizedBox(height: 150),
              EmergencyButton(
                onTap: () => debugPrint('Emergency Call Pressed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

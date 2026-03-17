import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/auth_text_field.dart';
import 'package:graduation_project/widgets/action_button.dart';
import 'package:graduation_project/widgets/emergency_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Color(0xff76545D),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff76545D),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Enter your registered email address below to receive password reset instructions.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 30),
              const AuthTextField(label: 'E-mail', icon: Icons.mail),
              const SizedBox(height: 30),
              ActionButton(
                label: 'Reset Password',
                onPressed: () => debugPrint('Reset Password Pressed'),
              ),
              const SizedBox(height: 50),
              EmergencyButton(
                onTap: () => debugPrint('Emergency Call Pressed'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

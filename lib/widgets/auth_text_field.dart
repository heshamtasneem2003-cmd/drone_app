import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController? controller;

  const AuthTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // جوه ملف auth_text_field.dart في الـ build
return Container(
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 248, 130, 130),
    borderRadius: BorderRadius.circular(15), // دوران الحواف
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4), // ظل خفيف جداً عشان يبان راقي
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 174, 12, 12)),
      labelText: label,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 3, 3, 3)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none, // بنشيل الخط التقليدي عشان نعتمد على الظل
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 174, 12, 12), // خط أحمر لما تضغطي عليه
          width: 1.5,
        ),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 226, 211, 211),
    ),
  ),
);
  }
}

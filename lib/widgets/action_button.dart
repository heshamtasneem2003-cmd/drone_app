import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Size minSize;

  const ActionButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0xffF4BBBB),
    this.foregroundColor = Colors.black,
    this.minSize = const Size(200, 50),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: minSize,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 20)),
    );
  }
}

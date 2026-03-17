import 'package:flutter/material.dart';

class EmergencyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const EmergencyButton({
    Key? key,
    required this.onTap,
    this.label = 'Emergency Call',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  size: 32,
                  color: Color.fromARGB(255, 229, 243, 255),
                ),
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
    );
  }
}

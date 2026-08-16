import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onPress;
  const BottomButton({
    super.key,
    required this.onPress,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 12, 143),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 3),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

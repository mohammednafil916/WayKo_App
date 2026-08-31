import 'package:flutter/material.dart';

class ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 187, 187, 187)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: TextStyle(color: Colors.black)),
        trailing: IconButton(
          onPressed: onTap,
          icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
        ),
        onTap: onTap,
      ),
    );
  }
}

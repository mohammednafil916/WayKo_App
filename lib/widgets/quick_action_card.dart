import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 50,
            color: const Color.fromARGB(255, 0, 12, 143),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Statistics",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color.fromARGB(255, 0, 12, 143),
                ),
              ),
              Text(
                "Detailed library overview",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}

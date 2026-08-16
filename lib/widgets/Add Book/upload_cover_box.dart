import 'package:flutter/material.dart';

class UploadCoverBox extends StatelessWidget {
  final VoidCallback onTap;

  const UploadCoverBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 61,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            SizedBox(width: 45),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload Cover",
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "JPG, PNG (Max, 2MB)",
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

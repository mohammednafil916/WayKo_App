import 'dart:typed_data';
import 'package:flutter/material.dart';

class UploadCoverBox extends StatelessWidget {
  final VoidCallback onTap;
  final Uint8List? image;

  const UploadCoverBox({super.key, required this.onTap, this.image});

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
        child: image == null
            ? Row(
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
              )
            : Row(
                children: [
                  SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.memory(
                      image!,
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cover Selected",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Tap to change cover",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

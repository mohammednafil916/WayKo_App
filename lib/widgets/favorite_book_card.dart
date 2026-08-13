import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';

class FavoriteBookCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String category;
  final String floor;
  final String section;
  final String shelf;
  final String copies;
  final String available;
  const FavoriteBookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.category,
    required this.floor,
    required this.section,
    required this.shelf,
    required this.copies,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.bookDetails);
      },
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                image,
                width: 65,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text(
                    author,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 3),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 2, 53, 95),
                        fontSize: 10,
                      ),
                    ),
                  ),

                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: Colors.red,
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          "$floor • $section • $shelf",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Icon(Icons.star_border, size: 22, color: Colors.blue),
                SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Copies",
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                        SizedBox(height: 3),
                        Text(
                          copies,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Container(height: 40, width: 1, color: Colors.grey),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          "Available",
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                        SizedBox(height: 3),
                        Text(
                          available,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

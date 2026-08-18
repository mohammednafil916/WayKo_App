import 'package:flutter/material.dart';
import 'package:wayko/widgets/Favorite/favorite_book_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Favorites Books"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Books you have marked as favorites",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 134, 200, 255),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("05 Books", style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: FavoriteBookCard(
                      image: "assets/images/book2.jpg",
                      title: "title",
                      author: "author",
                      category: "category",
                      floor: "floor 1",
                      section: "c1",
                      shelf: "shelf 1",
                      copies: "30",
                      available: "02",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

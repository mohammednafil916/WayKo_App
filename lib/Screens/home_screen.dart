import 'package:flutter/material.dart';
import 'package:wayko/Services/authentication_service.dart';
import 'package:wayko/widgets/banner_images.dart';
import 'package:wayko/widgets/statics_card.dart';
import 'package:wayko/widgets/quick_action_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String username = AuthenticationService.registerName ?? "User";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("WayKo"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, $username👋",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                "Here's what's happening in your library",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 10),
              BannerImages(),
              SizedBox(height: 10),
              Text(
                "Library Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 12, 143),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: StaticsCard(
                      title: "Total Books",
                      value: "1,250",
                      icon: Icons.library_books,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 213, 245, 177),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: StaticsCard(
                      title: "Available Books",
                      value: "1,100 ",
                      icon: Icons.book,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 179, 231, 255),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: StaticsCard(
                      title: "Borrowed Books",
                      value: "150",
                      icon: Icons.person,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 179, 231, 255),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: StaticsCard(
                      title: "Favorites",
                      value: "150",
                      icon: Icons.star_border,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 213, 245, 177),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 12, 143),
                ),
              ),
              QuickActionCard(),
            ],
          ),
        ),
      ),
    );
  }
}

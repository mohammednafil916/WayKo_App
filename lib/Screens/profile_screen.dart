import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/widgets/Profile/profile_analysis_card.dart';
import 'package:wayko/widgets/Profile/profile_action_card.dart';
import 'package:wayko/Models/user_model.dart';
import 'package:wayko/Services/hive_boxes.dart';
import 'package:wayko/Services/session_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  Future<void> loadUser() async {
    String? userId = await SessionService.getLoggedUserId();
    for (UserModel currentUser in HiveBoxes.userBox.values) {
      if (currentUser.id == userId) {
        setState(() {
          user = currentUser;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      child: Icon(Icons.person_2_sharp, size: 50),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user?.username ?? "User",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Library Owner",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      user?.email ?? "No email",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ProfileAnalysisCard(),

              SizedBox(height: 20),
              ProfileActionCard(icon: Icons.person, title: "Edit Profile"),
              SizedBox(height: 5),
              ProfileActionCard(icon: Icons.lock, title: "Edit Password"),
              SizedBox(height: 5),
              ProfileActionCard(
                icon: Icons.info_outline_rounded,
                title: "About WayKo",
              ),
              SizedBox(height: 10),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 187, 187, 187),
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text("Logout", style: TextStyle(color: Colors.red)),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Logout"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await SessionService.logout();
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.login,
                                  );
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/Providers/statistics_provider.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/widgets/Profile/profile_action_card.dart';
import 'package:wayko/widgets/Profile/profile_analysis_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final stats = ref.watch(libraryOverviewStatsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
              ProfileAnalysisCard(
                totalBooks: stats.totalBooks,
                availableBooks: stats.availableBooks,
                borrowedBooks: stats.borrowedBooks,
                favoriteBooks: stats.favoriteBooks,
              ),
              SizedBox(height: 20),
              ProfileActionCard(
                icon: Icons.person,
                title: "Edit Profile",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                },
              ),
              SizedBox(height: 5),
              ProfileActionCard(
                icon: Icons.lock,
                title: "Edit Password",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.editPassword);
                },
              ),
              SizedBox(height: 5),
              ProfileActionCard(
                icon: Icons.bar_chart,
                title: "View Statistics",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.statistics);
                },
              ),
              SizedBox(height: 5),
              ProfileActionCard(
                icon: Icons.info_outline_rounded,
                title: "About WayKo",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.wayKoAbout);
                },
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
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: Text("Logout"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(dialogContext);
                                  await ref
                                      .read(sessionProvider.notifier)
                                      .logout();

                                  if (!context.mounted) {
                                    return;
                                  }

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

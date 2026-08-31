import 'package:flutter/material.dart';
import 'package:wayko/Models/user_model.dart';
import 'package:wayko/Services/hive_boxes.dart';
import 'package:wayko/Services/session_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserModel? user;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }
    for (UserModel currentUser in HiveBoxes.userBox.values) {
      if (currentUser.id == userId) {
        setState(() {
          user = currentUser;
          usernameController.text = currentUser.username;
          emailController.text = currentUser.email;
        });
        break;
      }
    }
  }

  Future<void> updateProfile() async {
    if (user == null) {
      return;
    }
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    if (username.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }
    user!.username = username;
    user!.email = email;
    await user!.save();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Profile updated successfully")));
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateProfile,
                child: Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

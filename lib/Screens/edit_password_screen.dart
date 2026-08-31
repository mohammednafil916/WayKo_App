import 'package:flutter/material.dart';
import 'package:wayko/Models/user_model.dart';
import 'package:wayko/Services/hive_boxes.dart';
import 'package:wayko/Services/session_service.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }

    UserModel? user;

    for (UserModel currentUser in HiveBoxes.userBox.values) {
      if (currentUser.id == userId) {
        user = currentUser;
        break;
      }
    }
    if (user == null) {
      return;
    }
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }
    if (currentPasswordController.text != user.password) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Current password is incorrect")));
      return;
    }
    if (newPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("New password must contain at least 6 characters"),
        ),
      );
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("New passwords do not match")));
      return;
    }
    user.password = newPasswordController.text;
    await user.save();
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Password changed successfully")));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Password")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: obscureCurrentPassword,
              decoration: InputDecoration(
                labelText: "Current Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureCurrentPassword = !obscureCurrentPassword;
                    });
                  },
                  icon: Icon(
                    obscureCurrentPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: newPasswordController,
              obscureText: obscureNewPassword,
              decoration: InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureNewPassword = !obscureNewPassword;
                    });
                  },
                  icon: Icon(
                    obscureNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: confirmPasswordController,
              obscureText: obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: "Confirm New Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: changePassword,
                child: Text("Change Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

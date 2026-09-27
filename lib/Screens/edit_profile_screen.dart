import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Providers/profile_provider.dart';
import 'package:wayko/Providers/session_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    if (!_initialized && user != null) {
      usernameController.text = user.username;
      emailController.text = user.email;
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                onPressed: user == null ? null : updateProfile,
                child: Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    final user = ref.read(currentUserProvider);

    if (user == null) {
      return;
    }

    final username = usernameController.text.trim();
    final email = emailController.text.trim();

    if (username.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }

    await ref
        .read(profileProvider.notifier)
        .updateProfile(username: username, email: email);

    if (!mounted) return;

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
}

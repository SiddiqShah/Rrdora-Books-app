import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:redora/ViewModel/view_model.dart';
import 'package:redora/widgets/custom_snackbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final User? user = authViewModel.user;

    if (user == null) {
      return Scaffold(
        backgroundColor: const Color(0xff0F1030),
        appBar: AppBar(
          title: const Text('Profile', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xff0F1030),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: Text(
            'No user logged in',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    final TextEditingController nameController = TextEditingController(
      text: user.displayName ?? '',
    );
    final TextEditingController emailController = TextEditingController(
      text: user.email ?? '',
    );

    return Scaffold(
      backgroundColor: const Color(0xff0F1030),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Bold'),
        ),
        backgroundColor: const Color(0xff0F1030),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? Text(
                            (user.displayName?.isNotEmpty ?? false)
                                ? user.displayName![0].toUpperCase()
                                : user.email![0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0F1030),
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xff1255F1),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          CustomSnackbar.show(
                            context,
                            message: 'Profile picture editing coming soon!',
                            isError: false,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Editable Display Name
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Display Name',
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xff1E2A47),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Email (readonly)
            TextField(
              controller: emailController,
              enabled: false,
              style: const TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xff1E2A47),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Save Changes button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1255F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                final newName = nameController.text.trim();
                if (newName.isEmpty) {
                  CustomSnackbar.show(
                    context,
                    message: 'Display name cannot be empty',
                    isError: true,
                  );
                  return;
                }

                try {
                  await user.updateDisplayName(newName);
                  await user.reload();
                  authViewModel.clearError();
                  CustomSnackbar.show(
                    context,
                    message: 'Profile updated successfully!',
                    isError: false,
                  );
                } catch (e) {
                  CustomSnackbar.show(
                    context,
                    message: 'Failed to update profile: $e',
                    isError: true,
                  );
                }
              },
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins-Medium',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Account Info
            const Divider(color: Colors.white24),
            const SizedBox(height: 10),
            Text(
              'Account Created: ',
              style: const TextStyle(
                color: Colors.white70,
                fontFamily: 'Poppins-Medium',
              ),
            ),
            Text(
              user.metadata.creationTime != null
                  ? user.metadata.creationTime.toString()
                  : 'Unknown',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

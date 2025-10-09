import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redora/ViewModel/view_model.dart';
import 'package:redora/view/privacy_ans_policy.dart';
import 'package:redora/widgets/custom_snackbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xff0F1030),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Bold'),
        ),
        backgroundColor: const Color(0xff0F1030),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          // Account Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Account',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'Poppins-Medium',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.white),
            title: const Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              final email = authViewModel.user?.email;
              if (email == null) {
                CustomSnackbar.show(
                  context,
                  message: 'You are not logged in',
                  isError: true,
                );
                return;
              }
              final ok = await authViewModel.sendPasswordResetEmail(email);
              if (!context.mounted) return;
              if (ok) {
                CustomSnackbar.show(
                  context,
                  message: 'Password reset link sent to $email',
                  isError: false,
                );
              } else {
                CustomSnackbar.show(
                  context,
                  message:
                      authViewModel.errorMessage ??
                      'Failed to send reset email',
                  isError: true,
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          const Divider(color: Colors.white24),

          // App Preferences Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'App Preferences',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontFamily: 'Poppins-Medium',
              ),
            ),
          ),
          SwitchListTile(
            title: const Text(
              'Dark Mode',
              style: TextStyle(color: Colors.white),
            ),
            value: true, // You can make this dynamic later
            onChanged: (value) {
              CustomSnackbar.show(
                context,
                message: 'Dark mode coming soon!',
                isError: false,
              );
            },
            secondary: const Icon(Icons.dark_mode, color: Colors.white),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.white),
            title: const Text(
              'App Version',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              '1.0.0',
              style: TextStyle(color: Colors.white54),
            ),
            onTap: () {},
          ),
          const Divider(color: Colors.white24),

          // Logout Button
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xff1E2A47),
                  title: const Text(
                    'Confirm Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await authViewModel.logout();
                if (!context.mounted) return;
                Navigator.pop(context); // Go back to previous screen
                CustomSnackbar.show(
                  context,
                  message: 'Logged out successfully',
                  isError: false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redora/ViewModel/view_model.dart';
import '../view/login_screen.dart';
import '../widgets/custom_snackbar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff1E2A47),
        title: const Text('Logout', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await authViewModel.logout();

      if (!context.mounted) return;

      CustomSnackbar.show(
        context,
        message: 'Logged out successfully',
        isError: false,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final user = authViewModel.user;
    final String? photoURL = user?.photoURL;
    final String displayName = user?.displayName ?? 'User';

    return Drawer(
      backgroundColor: const Color(0xff1E2A47),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xff0F1030)),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: photoURL != null
                      ? NetworkImage(photoURL)
                      : null,
                  child: photoURL == null
                      ? Icon(Icons.person, size: 40, color: Colors.black)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text("Profile", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              CustomSnackbar.show(
                context,
                message: 'Profile page coming soon!',
                isError: false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text(
              "Settings",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              CustomSnackbar.show(
                context,
                message: 'Settings page coming soon!',
                isError: false,
              );
            },
          ),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _handleLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

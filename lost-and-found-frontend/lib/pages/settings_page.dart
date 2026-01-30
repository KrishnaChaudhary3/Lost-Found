import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _handleLogout(BuildContext context) {
    // 🔒 Future: Clear auth token from secure storage here
    // For now, show message and redirect to login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out")),
    );

    // 🧭 Redirect to login page (update route name if needed)
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTile(
            icon: Icons.account_circle,
            title: "Account",
            subtitle: "Manage your account",
            onTap: () {
              // Future: Navigate to Account Details Page
            },
          ),
          _buildTile(
            icon: Icons.notifications,
            title: "Notifications",
            subtitle: "Notification preferences",
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.lock,
            title: "Privacy & Security",
            subtitle: "Manage privacy settings",
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.info_outline,
            title: "About App",
            subtitle: "Version 1.0.0",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Lost & Found App",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 Krishna Inc.",
              );
            },
          ),
          _buildTile(
            icon: Icons.logout,
            title: "Logout",
            onTap: () => _handleLogout(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 3,
        onTap: (index) {
          final routes = ['/home', '/search', '/profile', '/settings'];
          if (index != 3) {
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.teal),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}

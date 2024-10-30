import 'package:flutter/material.dart';
import 'package:ichat/auth/auth_service.dart';
import 'package:ichat/pages/about.dart';
import 'package:ichat/pages/settings.dart';
import 'package:ichat/widgets/drawer_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void logout() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Icon(
              Icons.chat_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'HOME',
            leading: Icons.home_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerTile(
            title: 'SETTINGS',
            leading: Icons.settings_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
            },
          ),
          DrawerTile(
            title: 'ABOUT',
            leading: Icons.info_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AboutPage(),
              ));
            },
          ),
          const Spacer(),
          DrawerTile(
            title: 'LOGOUT',
            leading: Icons.logout_rounded,
            onTap: () {
              Navigator.pop(context);
              logout();
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

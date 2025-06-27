import 'package:chat_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  void logout() {
    final auth = AuthService();
    auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.transparent, // or your desired color
                ),
                child: Center(
                  child: Icon(
                    Icons.message_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              // home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "H O M E",
                    style: TextStyle().copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),

                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "S E T T I N G S",
                    style: TextStyle().copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 20),
            child: ListTile(
              title: Text(
                "L O G O U T",
                style: TextStyle().copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}

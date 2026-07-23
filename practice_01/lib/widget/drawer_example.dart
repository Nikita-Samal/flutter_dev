import 'package:flutter/material.dart';

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawer Example"),
        backgroundColor: Colors.green,
      ),

      drawer: Drawer(
        child: ListView(
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  "My Drawer",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),

      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void showLogoutConfirmationDialog(VoidCallback onLogout) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onLogout(); // Call the logout callback
              },
              child: const Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}

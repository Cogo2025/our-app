import 'package:flutter/material.dart';
import 'package:lorry_app/features/account_selection/driver_details.dart'; // Correct path for DriverDetailsScreen
import 'package:lorry_app/features/account_selection/owner_details.dart'; // Import Owner Details Page
import 'package:lorry_app/core/theme/light_theme.dart'; // Correct path for light theme

class AccountSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor, // Use light theme
      appBar: AppBar(
        title: Text("Create Your Account As"),
        backgroundColor: lightTheme.primaryColor, // Use primary color from theme
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                "Create your account as",
                style: lightTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Driver Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightTheme.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Navigate to Driver Details Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DriverDetailsScreen()),
                  );
                },
                child: Text(
                  "Driver",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),

              // Owner Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightTheme.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Navigate to Owner Details Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OwnerDetailsPage()),
                  );
                },
                child: Text(
                  "Owner",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

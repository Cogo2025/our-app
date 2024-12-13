import 'package:flutter/material.dart';
import 'package:lorry_app/core/theme/light_theme.dart'; // Correct path for your theme
import "otp_verification_screen.dart";

class PhoneNumberInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor, // Use light theme
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                "Enter your Phone Number",
                style: lightTheme.textTheme.titleLarge, // Title from theme
              ),
              const SizedBox(height: 24),

              // Phone number TextField
              TextField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // Next Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightTheme.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Navigate to OTP verification screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OTPVerificationScreen()),
                  );
                },
                child: Text(
                  "Next",
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

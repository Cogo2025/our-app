import 'package:flutter/material.dart';
import 'package:lorry_app/core/theme/light_theme.dart'; // Correct path for your theme

class OTPVerificationScreen extends StatelessWidget {
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
                "Enter the OTP sent to your phone",
                style: lightTheme.textTheme.titleLarge, // Title from theme
              ),
              const SizedBox(height: 24),

              // OTP TextField
              TextField(
                decoration: InputDecoration(
                  labelText: "OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              // Verify Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightTheme.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  // TODO: Add OTP verification logic
                },
                child: Text(
                  "Verify OTP",
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

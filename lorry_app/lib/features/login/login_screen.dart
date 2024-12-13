import 'package:flutter/material.dart';
import 'package:lorry_app/core/theme/light_theme.dart'; // Correct path
import 'package:lorry_app/features/login/phone_number_input_screen.dart'; // Correct path for your theme
import 'package:lorry_app/features/account_selection/account_selection_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor, // Use light theme
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo
                Image.asset(
                  'assets/images/lorryicon.jpg',
                  height: 100,
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  "Login to explore!",
                  style: lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),

                // Email TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightTheme.primaryColor,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // TODO: Add login logic
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),

                // OR divider
                Text("OR", style: TextStyle(color: Colors.black)),
                const SizedBox(height: 16),

                // Phone Login Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Navigate to phone number input page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhoneNumberInputScreen()),
                    );
                  },
                  icon: Icon(Icons.phone, color: Colors.black),
                  label: Text(
                    "Sign in with Phone",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 24),

                // Registration link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New to the app? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountSelectionPage()),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

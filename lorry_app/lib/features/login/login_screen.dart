import 'package:flutter/material.dart';
import 'package:lorry_app/core/theme/light_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lorry_app/features/home_page/owner_home_page.dart';
import 'package:lorry_app/features/home_page/driver_home_page.dart';
import 'package:lorry_app/features/account_selection/account_selection_screen.dart';
import 'package:lorry_app/features/login/phone_number_input_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  String userType = 'owner'; // Default is 'owner', can be changed dynamically.

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login for both owner and driver
  // Import SharedPreferences

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final url = Uri.parse(
        userType == 'owner'
            ? 'http://localhost:5000/api/owner/login'
            : 'http://localhost:5000/api/driver/login',
      );

      print("🔹 Sending Login Request...");
      print("📧 Email: ${emailController.text}");
      print("🔑 Password: ${passwordController.text}");

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text,
          }),
        );

        print("🔹 Response Code: ${response.statusCode}");
        print("🔹 Response Body: ${response.body}");

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          String token = data['token']; // Extract token
          print("✅ Login Successful: Token - $token");

          // ✅ Store Token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);
          print("📝 Token Saved in SharedPreferences");

          // Navigate to the respective home page
          if (userType == 'owner') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OwnerHomePage()),
            );
          } else if (userType == 'driver') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DriverHomePage()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid email or password')),
          );
        }
      } catch (e) {
        print('🚨 Error occurred during login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme.scaffoldBackgroundColor,
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

                // User Type Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'owner',
                      groupValue: userType,
                      onChanged: (String? value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                    Text("Owner"),
                    Radio<String>(
                      value: 'driver',
                      groupValue: userType,
                      onChanged: (String? value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                    Text("Driver"),
                  ],
                ),
                const SizedBox(height: 24),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email TextField
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password TextField
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightTheme.primaryColor,
                                minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: _login,
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
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  PhoneNumberInputScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
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
                                    builder: (context) =>
                                        AccountSelectionPage()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

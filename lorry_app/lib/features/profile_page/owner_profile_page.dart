import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lorry_app/features/profile_page/your-post/your_post.dart';
import 'package:lorry_app/features/custom-navbar/owner_custom_navbar.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? error;
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        setState(() {
          error = 'No authentication token found';
          isLoading = false;
        });
        return;
      }

      print('Token found: $token'); // Debug print

      final response = await http.get(
        Uri.parse('http://localhost:5000/api/owner/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userData = data;
          isLoading = false;
          error = null;
        });
      } else {
        setState(() {
          error = 'Failed to load profile: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e'); // Debug print
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index != 4) {
      Navigator.pop(context);
    }
  }

  Future<void> _handleLogout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading 
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.blue.shade700,
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, size: 50, color: Colors.blue),
                            ),
                            SizedBox(height: 16),
                            Text(
                              userData?['name'] ?? 'N/A',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              userData?['email'] ?? 'N/A',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoTile('Phone', userData?['phoneNumber'] ?? 'N/A'),
                            _buildInfoTile('Gender', userData?['gender'] ?? 'N/A'),
                            _buildInfoTile('Date of Birth', 
                              userData?['dob'] != null 
                                ? DateTime.parse(userData!['dob']).toString().split(' ')[0]
                                : 'N/A'
                            ),
                            _buildInfoTile('CIN Number', userData?['cinNumber'] ?? 'N/A'),
                          ],
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.post_add),
                        title: Text('View Posts'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => YourPostsPage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.contact_support),
                        title: Text('Contact Us'),
                        onTap: () {
                          // Contact Us functionality
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.report_problem),
                        title: Text('Report Issue'),
                        onTap: () {
                          // Report Issue functionality
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text('Logout', style: TextStyle(color: Colors.red)),
                        onTap: _handleLogout,
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: CustomNavbar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
        onPostTap: () {
          print("Post action tapped!");
        },
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

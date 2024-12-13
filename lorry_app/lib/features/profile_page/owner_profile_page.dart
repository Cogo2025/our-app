import 'package:flutter/material.dart';
import '../custom-navbar/driver_custom_navbar.dart'; // Ensure this path is correct

class OwnerProfilePage extends StatelessWidget {
  final String name;
  
  final String dob;
  final String gender;
  final String phoneNumber;
  final String CINNumber;

  const OwnerProfilePage({
    Key? key,
    required this.name,
    required this.dob,
    required this.gender,
    required this.phoneNumber,
    
    required this.CINNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blueAccent,
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Name
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Profile Details Card
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Date of Birth
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Text(
                            "Date of Birth: $dob",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Gender
                      Row(
                        children: [
                          const Icon(Icons.person_outline,
                              color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Text(
                            "Gender: $gender",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Phone Number
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Text(
                            "Phone Number: $phoneNumber",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),

                      

                      
                      const SizedBox(height: 16),

                      // License Number
                      Row(
                        children: [
                          const Icon(Icons.card_membership,
                              color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Text(
                            "CIN Number: $CINNumber",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Edit Profile Button
              ElevatedButton.icon(
                onPressed: () {
                  // Add functionality for editing profile
                  print("Edit Profile Tapped");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profile"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(
        selectedIndex: 3, // Set default index to the Profile tab
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(
                context, '/home'); // Redirect to Home
          } else if (index == 3) {
            // Stay on the Profile Page
          }
          // Handle other navigation cases if needed
        },
        onPostTap: () {
          print("Post action triggered");
        },
      ),
    );
  }
}

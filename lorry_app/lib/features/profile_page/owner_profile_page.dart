import 'package:flutter/material.dart';
import 'package:lorry_app/features/profile_page/your-post/your_post.dart';

void main() {
  runApp(MaterialApp(
    home: UserProfilePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Owner Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // Replace with user image
                    ),
                  ),
                  SizedBox(width: 16),
                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vishal',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              '+9194885456',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.email, size: 16, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              'vishal@gmail.com',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              'Namakkal',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Edit Icon
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // Edit functionality
                    },
                  ),
                ],
              ),
            ),

            // "Verify Profile" Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Action for profile verification
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    SizedBox(width: 10),
                    Text(
                      'Edit Your Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Options Section
            ListTile(
              leading: Icon(Icons.post_add, color: Colors.blue.shade700),
              title: Text('View Posts'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Navigate to View Posts
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>YourPostsPage()),
                        );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.blue.shade700),
              title: Text('Contact Us'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Navigate to Contact Us
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.blue.shade700),
              title: Text('Share App'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Add Share App functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem, color: Colors.blue.shade700),
              title: Text('Report an Issue'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Navigate to Report Issue
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Add Logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}

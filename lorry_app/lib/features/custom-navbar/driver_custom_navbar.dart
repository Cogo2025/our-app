import 'package:flutter/material.dart';
import '../profile_page/driver_profile_page.dart';
import '../home_page/driver_home_page.dart';
import '../post_page/driver_post_page.dart'; // Import DriverPostPage

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPostTap;

  const CustomNavbar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    required this.onPostTap, // Accept the callback for the '+' icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DriverHomePage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => onTap(1),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DriverPostPage()), // Navigate to the post page
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.local_shipping),
            onPressed: () => onTap(2),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverProfilePage(
                    name: "John Doe",
                    dob: "1990-01-01",
                    gender: "Male",
                    phoneNumber: "1234567890",
                    licenseNumber: "AB12345",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

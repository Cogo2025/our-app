import 'package:flutter/material.dart';
import '../profile_page/Owner_profile_page.dart';
import '../home_page/owner_home_page.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPostTap; // Add a callback for the '+' icon

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
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Distribute icons evenly
        children: [
          // Home icon: Navigate to OwnerHomePage
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OwnerHomePage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => onTap(1),
          ),

          // Centered '+' icon (for post action)
          GestureDetector(
            onTap: onPostTap, // Trigger the callback when + is tapped
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

          // Right side items
          IconButton(
            icon: const Icon(Icons.local_shipping),
            onPressed: () => onTap(2),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to owner Profile Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OwnerProfilePage(
                    name: "John Doe", // Replace with actual name if dynamic
                    dob: "1990-01-01", // Replace with actual DOB
                    gender: "Male", // Replace with actual gender
                    phoneNumber:
                        "1234567890", // Replace with actual phone number
                    CINNumber: "AB12345", // Replace with actual license number
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

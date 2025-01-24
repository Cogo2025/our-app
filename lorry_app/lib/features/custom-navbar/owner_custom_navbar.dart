import 'package:flutter/material.dart';
import 'package:lorry_app/features/cart-page/cart_page.dart';
import '../home_page/owner_home_page.dart';
import '../post_page/owner_post_page.dart'; // Import the owner post page
import 'package:lorry_app/features/profile_page/owner_profile_page.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onPostTap;

  const CustomNavbar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    required this.onPostTap,
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
                  builder: (context) => const OwnerHomePage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()),
                          );
            }
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OwnerPostPage()), // Navigate to the post page
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
                  builder: (context) => (UserProfilePage()  
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

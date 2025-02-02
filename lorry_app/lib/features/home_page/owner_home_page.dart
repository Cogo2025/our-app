import 'package:flutter/material.dart';
import 'package:lorry_app/features/home_page/search_page.dart';
import 'package:lorry_app/features/notification-page/notification_page.dart';
import 'package:lorry_app/features/profile_page/owner_profile_page.dart';
import '../custom-navbar/owner_custom_navbar.dart' as owner_navbar;

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({Key? key}) : super(key: key);

  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  int _selectedIndex = 0;
  bool _showAllCards = false; // Track whether to show all cards

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on index
    switch (index) {
      case 0: // Home
        break;
      case 1: // Search
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchVehiclesPage()),
        );
        break;
      case 2: // Post
        // Handle post action
        break;
      case 3: // Notifications
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationMatchedPage()),
        );
        break;
      case 4: // Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchVehiclesPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationMatchedPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Section
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cogo App',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchVehiclesPage()),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotificationMatchedPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Slider Section
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: PageController(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Slide ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Cards Section
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 3 / 2, // Adjust aspect ratio
                    ),
                    itemCount: _showAllCards ? 9 : 4,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.amber,
                        child: Center(
                          child: Text(
                            'Card ${index + 1}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // "View All" Button
                if (!_showAllCards)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAllCards = true;
                      });
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: owner_navbar.CustomNavbar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
        onPostTap: () {
          print("Post action tapped!");
        },
      ),
    );
  }
}

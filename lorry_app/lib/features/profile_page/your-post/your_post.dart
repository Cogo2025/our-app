import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: YourPostsPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class YourPostsPage extends StatelessWidget {
  // Example list of posts
  final List<Map<String, String>> posts = [
    {
      'title': 'Trip to Coimbatore',
      'content': 'Explored beautiful places and met amazing people.',
      'image': 'https://via.placeholder.com/150', // Placeholder image URL
    },
    {
      'title': 'My First Flutter App',
      'content': 'Finally finished my first mobile app using Flutter!',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Weekend Adventure',
      'content': 'Went on a hike and enjoyed some quality time in nature.',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Posts'),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    post['image'] ?? '',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Title
                      Text(
                        post['title'] ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Post Content
                      Text(
                        post['content'] ?? '',
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
                // Edit/Delete Buttons
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Edit functionality
                      },
                      child: Text('Edit'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Delete functionality
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      
    );
  }
}

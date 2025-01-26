import 'package:flutter/material.dart';
import 'package:lorry_app/features/post_page/owner_post_page.dart';
import 'package:lorry_app/features/post_data.dart';

class YourPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Posts'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: ownerPosts.isEmpty
          ? Center(child: Text("No posts yet."))
          : ListView.builder(
              itemCount: ownerPosts.length,
              itemBuilder: (context, index) {
                final post = ownerPosts[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (post['photos'] != null &&
                          (post['photos'] as List).isNotEmpty)
                        Image.file(
                          post['photos'][0],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Truck Type: ${post['truckType'] ?? ''}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("BS Version: ${post['bsVersion'] ?? ''}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

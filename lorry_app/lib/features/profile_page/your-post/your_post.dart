import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lorry_app/features/post_data.dart';

class YourPostsPage extends StatefulWidget {
  @override
  _YourPostsPageState createState() => _YourPostsPageState();
}

class _YourPostsPageState extends State<YourPostsPage> {
  List<Post> posts = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        setState(() {
          error = 'Not authenticated';
          isLoading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('http://localhost:5000/api/owner/posts/my-posts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          posts = data.map((post) => Post.fromJson(post)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load posts: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error in fetchPosts: $e');
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Posts'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : posts.isEmpty
                  ? Center(child: Text("No posts yet."))
                  : RefreshIndicator(
                      onRefresh: fetchPosts,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Left side - Image
                                  if (post.photos.isNotEmpty)
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                      ),
                                      child: Image.network(
                                        'http://192.168.1.100:5000/${post.photos[0]}', // Replace with your server IP
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey[300],
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  
                                  // Right side - Post details
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.local_shipping, 
                                                size: 16, 
                                                color: Colors.blue.shade700
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                post.truckType,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "BS: ${post.bsVersion}",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              Text(
                                                post.driverType,
                                                style: TextStyle(
                                                  color: Colors.blue.shade700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time, 
                                                size: 14, 
                                                color: Colors.grey
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                post.timeDuration,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, 
                                                size: 14, 
                                                color: Colors.grey
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                post.location,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}

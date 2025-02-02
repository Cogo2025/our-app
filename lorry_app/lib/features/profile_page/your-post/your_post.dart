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
          error = 'Failed to load posts';
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
                  ? Center(child: Text('No posts yet'))
                  : RefreshIndicator(
                      onRefresh: fetchPosts,
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (post.photos.isNotEmpty)
                                  Image.network(
                                    'http://localhost:5000/${post.photos[0]}',
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                      height: 200,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.error),
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Truck Type: ${post.truckType}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text('BS Version: ${post.bsVersion}'),
                                      Text('Driver Type: ${post.driverType}'),
                                      Text('Duration: ${post.timeDuration}'),
                                      Text('Location: ${post.location}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}

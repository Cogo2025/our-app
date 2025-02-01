import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';  // Make sure to import this package

class OwnerPostPage extends StatefulWidget {
  @override
  _OwnerPostPageState createState() => _OwnerPostPageState();
}

class _OwnerPostPageState extends State<OwnerPostPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? _truckType;
  String? _bsVersion;
  String? _driverType;
  String? _timeDuration;
  String? _location;
  List<File> _photos = [];
  final _picker = ImagePicker();
  
  // User token (make sure this is coming from your login response or shared preferences)
  String _userToken = "your_jwt_token";  // Replace with your actual token

  // Dropdown options
  final List<String> truckTypes = [
    "Light",
    "Medium",
    "Heavy",
    "Mini",
    "Flatbed",
    "Box"
  ];
  final List<String> bsVersions = ["BS3", "BS4", "BS6"];
  final List<String> driverTypes = [
    "Owner Driver",
    "Driver Provided",
    "Self-Driven"
  ];
  final List<String> timeDurations = [
    "1 day",
    "1 week",
    "1 month",
    "3 months",
    "6 months",
    "1 year"
  ];
  final List<String> locations = [
    "Delhi",
    "Mumbai",
    "Chennai",
    "Bangalore",
    "Kolkata"
  ];

  // Method to extract the user ID from the JWT token
  String _getOwnerIdFromToken() {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(_userToken);
      print('Decoded Token Data: $decodedToken');
      return decodedToken['userId'];  // Or use 'ownerId' depending on your token structure
    } catch (e) {
      print('Error decoding token: $e');
      throw FormatException('Invalid token format');
    }
  }

  // Pick images for lorry
  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _photos = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  // Submit Post
  Future<void> _submitPost() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://localhost:5000/api/owner/posts'; // Correct the backend URL
      String ownerId = _getOwnerIdFromToken();

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'ownerId': ownerId, // Make sure to include the ownerId in the post request
            'truckType': _truckType,
            'bsVersion': _bsVersion,
            'driverType': _driverType,
            'timeDuration': _timeDuration,
            'location': _location,
            'photos': _photos.map((file) => file.path).toList(),
          }),
        );

        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Post created successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create post')),
          );
        }
      } catch (error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Owner Post"), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _truckType,
                  decoration: InputDecoration(
                      labelText: "Truck Type", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _truckType = value),
                  items: truckTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select truck type' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _bsVersion,
                  decoration: InputDecoration(
                      labelText: "BS Version", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _bsVersion = value),
                  items: bsVersions
                      .map((version) => DropdownMenuItem(
                          value: version, child: Text(version)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select BS version' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _driverType,
                  decoration: InputDecoration(
                      labelText: "Driver Type", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _driverType = value),
                  items: driverTypes
                      .map((driver) =>
                          DropdownMenuItem(value: driver, child: Text(driver)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select driver type' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _timeDuration,
                  decoration: InputDecoration(
                      labelText: "Time Duration", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _timeDuration = value),
                  items: timeDurations
                      .map((duration) =>
                          DropdownMenuItem(value: duration, child: Text(duration)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select time duration' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _location,
                  decoration: InputDecoration(
                      labelText: "Location", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _location = value),
                  items: locations
                      .map((location) =>
                          DropdownMenuItem(value: location, child: Text(location)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select location' : null,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: _pickImages, child: Text("Upload Lorry Photos")),
                SizedBox(height: 16),
                if (_photos.isNotEmpty)
                  Wrap(
                    spacing: 8.0,
                    children: _photos.map((file) {
                      return Stack(
                        children: [
                          Image.file(file,
                              width: 100, height: 100, fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () =>
                                  setState(() => _photos.remove(file)),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitPost,
                  child: Text("Post"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

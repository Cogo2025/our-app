import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lorry_app/features/post_data.dart'; // Import global post storage
import 'package:lorry_app/features/home_page/owner_home_page.dart'; // Redirect here after posting

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
  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      // Store the post in the global list
      ownerPosts.add({
        'truckType': _truckType,
        'bsVersion': _bsVersion,
        'driverType': _driverType,
        'timeDuration': _timeDuration,
        'location': _location,
        'photos': _photos.map((file) => file.path).toList(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Post successfully created!'),
            duration: Duration(seconds: 2)),
      );

      // Redirect to Owner Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OwnerHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Owner Post"), backgroundColor: Colors.blueAccent),
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

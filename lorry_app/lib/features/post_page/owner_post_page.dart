import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OwnerPostPage extends StatefulWidget {
  const OwnerPostPage({Key? key}) : super(key: key);

  @override
  _OwnerPostPageState createState() => _OwnerPostPageState();
}

class _OwnerPostPageState extends State<OwnerPostPage> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? _truckType;
  String? _bsVersion;
  String? _driverType;
  String? _timeDuration;
  String? _location;

  // Photo selection
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

  // Submit post
  void _submitPost() {
    // You can replace this with your backend submission logic
    if (_formKey.currentState!.validate()) {
      // Collect form data and photos
      // Normally here, you would make an API call to submit the data
      print("Post submitted with:");
      print("Truck Type: $_truckType");
      print("BS Version: $_bsVersion");
      print("Driver Type: $_driverType");
      print("Time Duration: $_timeDuration");
      print("Location: $_location");
      print("Photos: $_photos");

      // Display a confirmation or navigate to another page
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Post successfully created!')));
      Navigator.pop(context); // Navigate back to the previous page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Post"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Truck Type Dropdown
                DropdownButtonFormField<String>(
                  value: _truckType,
                  decoration: InputDecoration(
                    labelText: "Truck Type",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _truckType = value;
                    });
                  },
                  items: truckTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select truck type' : null,
                ),
                const SizedBox(height: 16),

                // BS Version Dropdown
                DropdownButtonFormField<String>(
                  value: _bsVersion,
                  decoration: InputDecoration(
                    labelText: "BS Version",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _bsVersion = value;
                    });
                  },
                  items: bsVersions
                      .map((version) => DropdownMenuItem(
                          value: version, child: Text(version)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select BS version' : null,
                ),
                const SizedBox(height: 16),

                // Driver Type Dropdown
                DropdownButtonFormField<String>(
                  value: _driverType,
                  decoration: InputDecoration(
                    labelText: "Driver Type",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _driverType = value;
                    });
                  },
                  items: driverTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select driver type' : null,
                ),
                const SizedBox(height: 16),

                // Time Duration Dropdown
                DropdownButtonFormField<String>(
                  value: _timeDuration,
                  decoration: InputDecoration(
                    labelText: "Time Duration",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _timeDuration = value;
                    });
                  },
                  items: timeDurations
                      .map((duration) => DropdownMenuItem(
                          value: duration, child: Text(duration)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select time duration' : null,
                ),
                const SizedBox(height: 16),

                // Location Dropdown
                DropdownButtonFormField<String>(
                  value: _location,
                  decoration: InputDecoration(
                    labelText: "Location",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _location = value;
                    });
                  },
                  items: locations
                      .map((loc) =>
                          DropdownMenuItem(value: loc, child: Text(loc)))
                      .toList(),
                  validator: (value) =>
                      value == null ? 'Please select location' : null,
                ),
                const SizedBox(height: 16),

                // Next Button
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text("Upload Lorry Photos"),
                ),
                const SizedBox(height: 16),

                // Display selected photos
                if (_photos.isNotEmpty) ...[
                  Text("Selected Photos:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: _photos.map((file) {
                      return Image.file(
                        file,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Post Button
                ElevatedButton(
                  onPressed: _submitPost,
                  child: Text("Post"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

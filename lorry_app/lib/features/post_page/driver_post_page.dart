import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DriverPostPage extends StatefulWidget {
  const DriverPostPage({Key? key}) : super(key: key);

  @override
  _DriverPostPageState createState() => _DriverPostPageState();
}

class _DriverPostPageState extends State<DriverPostPage> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? _knownDrivingType;
  String? _timeDuration;
  String? _location;

  // Photo selection
  List<File> _photos = [];
  final _picker = ImagePicker();

  // Dropdown options
  final List<String> drivingTypes = ["Light Truck", "Medium Truck", "Heavy Truck", "Mini Truck", "Flatbed Truck"];
  final List<String> timeDurations = ["1 day", "1 week", "1 month", "3 months", "6 months", "1 year"];
  final List<String> locations = ["Delhi", "Mumbai", "Chennai", "Bangalore", "Kolkata"];

  // Pick images for truck
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
    if (_formKey.currentState!.validate()) {
      // Normally here, you would make an API call to submit the data
      print("Post submitted with:");
      print("Known Driving Type: $_knownDrivingType");
      print("Time Duration: $_timeDuration");
      print("Location: $_location");
      print("Photos: $_photos");

      // Display a confirmation or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post successfully created!')));
      Navigator.pop(context); // Navigate back to the previous page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Post"),
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
                // Known Driving Type Dropdown
                DropdownButtonFormField<String>(
                  value: _knownDrivingType,
                  decoration: InputDecoration(
                    labelText: "Known Driving Type",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _knownDrivingType = value;
                    });
                  },
                  items: drivingTypes
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  validator: (value) => value == null ? 'Please select driving type' : null,
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
                      .map((duration) => DropdownMenuItem(value: duration, child: Text(duration)))
                      .toList(),
                  validator: (value) => value == null ? 'Please select time duration' : null,
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
                      .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                      .toList(),
                  validator: (value) => value == null ? 'Please select location' : null,
                ),
                const SizedBox(height: 16),

                // Next Button
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text("Next - Upload Truck Photos"),
                ),
                const SizedBox(height: 16),

                // Display selected photos
                if (_photos.isNotEmpty) ...[
                  Text("Selected Photos:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

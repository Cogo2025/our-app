import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lorry_app/features/home_page/owner_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; // Add this import for TimeoutException
import 'package:http_parser/http_parser.dart';

class OwnerPostPage extends StatefulWidget {
  @override
  _OwnerPostPageState createState() => _OwnerPostPageState();
}

class _OwnerPostPageState extends State<OwnerPostPage> {
  final _formKey = GlobalKey<FormState>();
  String? _truckType, _bsVersion, _driverType, _timeDuration, _location;
  final _picker = ImagePicker();

  List<Uint8List> _photoBytes = []; // Store image data for web

  final List<String> truckTypes = ["Light", "Medium", "Heavy", "Mini", "Flatbed", "Box"];
  final List<String> bsVersions = ["BS3", "BS4", "BS6"];
  final List<String> driverTypes = ["24hrs", "12hrs"];
  final List<String> timeDurations = ["1 day", "1 week", "1 month", "3 months", "6 months", "1 year"];
  final List<String> locations = ["Delhi", "Mumbai", "Chennai", "Bangalore", "Kolkata"];

  @override
  void initState() {
    super.initState();
    // Set default values for the dropdown fields
    _truckType = truckTypes[0]; 
    _bsVersion = bsVersions[0]; 
    _driverType = driverTypes[0]; 
    _timeDuration = timeDurations[0]; 
    _location = locations[0]; 
  }

  // Picking Images (Works on Web & Mobile)
  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      List<Uint8List> imageBytesList = [];
      for (XFile file in pickedFiles) {
        Uint8List bytes = await file.readAsBytes();
        imageBytesList.add(bytes);
      }
      setState(() {
        _photoBytes = imageBytesList;
      });
    }
  }

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) return;

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Navigator.pop(context); // Hide loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Authentication failed. Please login again.")),
        );
        return;
      }

      // Update the URL to use your server's IP address
      var url = Uri.parse("http://localhost:5000/api/posts"); // Replace with your server IP
      var request = http.MultipartRequest("POST", url);
      

      // Add headers
      request.headers.addAll({
        "Authorization": "Bearer $token",
      }); // Removed Content-Type header as it's set automatically for multipart requests

      // Add form fields
      request.fields.addAll({
        "truckType": _truckType!,
        "bsVersion": _bsVersion!,
        "driverType": _driverType!,
        "timeDuration": _timeDuration!,
        "location": _location!,
      });

      // Add photos
      if (_photoBytes.isNotEmpty) {
        for (int i = 0; i < _photoBytes.length; i++) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'photos',
              _photoBytes[i],
              filename: 'image_$i.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        }
      }

      print('Sending request to: ${request.url}');
      print('Headers: ${request.headers}');
      print('Fields: ${request.fields}');
      print('Number of files: ${request.files.length}');

      var streamedResponse = await request.send().timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );
      
      var response = await http.Response.fromStream(streamedResponse);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Navigator.pop(context); // Hide loading

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Post created successfully!")),
        );
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => OwnerHomePage())
        );
      } else {
        var responseData = jsonDecode(response.body);
        var errorMsg = responseData['error'] ?? "Unknown error occurred";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $errorMsg")),
        );
      }
    } catch (e) {
      print('Error during post submission: $e');
      Navigator.pop(context); // Hide loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create post: ${e.toString()}")),
      );
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
                  decoration: InputDecoration(labelText: "Truck Type", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _truckType = value),
                  items: truckTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                  validator: (value) => value == null || value.isEmpty ? 'Please select truck type' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _bsVersion,
                  decoration: InputDecoration(labelText: "BS Version", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _bsVersion = value),
                  items: bsVersions.map((version) => DropdownMenuItem(value: version, child: Text(version))).toList(),
                  validator: (value) => value == null || value.isEmpty ? 'Please select BS version' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _driverType,
                  decoration: InputDecoration(labelText: "Driver Type", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _driverType = value),
                  items: driverTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                  validator: (value) => value == null || value.isEmpty ? 'Please select driver type' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _timeDuration,
                  decoration: InputDecoration(labelText: "Time Duration", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _timeDuration = value),
                  items: timeDurations.map((duration) => DropdownMenuItem(value: duration, child: Text(duration))).toList(),
                  validator: (value) => value == null || value.isEmpty ? 'Please select time duration' : null,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _location,
                  decoration: InputDecoration(labelText: "Location", border: OutlineInputBorder()),
                  onChanged: (value) => setState(() => _location = value),
                  items: locations.map((location) => DropdownMenuItem(value: location, child: Text(location))).toList(),
                  validator: (value) => value == null || value.isEmpty ? 'Please select location' : null,
                ),
                SizedBox(height: 16),
                ElevatedButton(onPressed: _pickImages, child: Text("Upload Lorry Photos")),
                SizedBox(height: 16),
                if (_photoBytes.isNotEmpty)
                  Wrap(
                    spacing: 8.0,
                    children: _photoBytes.map((bytes) {
                      return Stack(
                        children: [
                          Image.memory(bytes, width: 100, height: 100, fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () => setState(() => _photoBytes.remove(bytes)),
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
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

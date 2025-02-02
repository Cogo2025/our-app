import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import '../home_page/owner_home_page.dart';

class OwnerPostPage extends StatefulWidget {
  @override
  _OwnerPostPageState createState() => _OwnerPostPageState();
}

class _OwnerPostPageState extends State<OwnerPostPage> {
  final _formKey = GlobalKey<FormState>();
  List<Uint8List> _photoBytes = [];
  List<File> _photos = [];
  final _picker = ImagePicker();

  String? _truckType;
  String? _bsVersion;
  String? _driverType;
  String? _timeDuration;
  String? _location;

  final List<String> truckTypes = ["Light", "Medium", "Heavy", "Mini", "Flatbed", "Box"];
  final List<String> bsVersions = ["BS3", "BS4", "BS6"];
  final List<String> driverTypes = ["Owner Driver", "Driver Provided", "Self-Driven"];
  final List<String> timeDurations = ["1 day", "1 week", "1 month", "3 months", "6 months", "1 year"];
  final List<String> locations = ["Delhi", "Mumbai", "Chennai", "Bangalore", "Kolkata"];

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _photos = pickedFiles.map((file) => File(file.path)).toList();
        _photoBytes = _photos.map((file) => file.readAsBytesSync()).toList();
      });
    }
  }

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) return;

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
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Authentication failed. Please login again.")),
        );
        return;
      }

      var url = Uri.parse("http://localhost:5000/api/owner/posts");
      var request = http.MultipartRequest("POST", url);
      
      request.headers.addAll({
        "Authorization": "Bearer $token",
      });

      request.fields.addAll({
        "truckType": _truckType!,
        "bsVersion": _bsVersion!,
        "driverType": _driverType!,
        "timeDuration": _timeDuration!,
        "location": _location!,
      });

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

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Navigator.pop(context); // Remove loading dialog

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Post created successfully!")),
        );
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OwnerHomePage()),
        );
      } else {
        var responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['error'] ?? 'Failed to create post')),
        );
      }
    } catch (e) {
      print('Error during post submission: $e');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create post: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _truckType,
                  decoration: InputDecoration(labelText: 'Truck Type'),
                  items: truckTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a truck type';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _truckType = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _bsVersion,
                  decoration: InputDecoration(labelText: 'BS Version'),
                  items: bsVersions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a BS version';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _bsVersion = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _driverType,
                  decoration: InputDecoration(labelText: 'Driver Type'),
                  items: driverTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a driver type';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _driverType = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _timeDuration,
                  decoration: InputDecoration(labelText: 'Time Duration'),
                  items: timeDurations.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a time duration';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _timeDuration = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _location,
                  decoration: InputDecoration(labelText: 'Location'),
                  items: locations.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a location';
                    }
                    return null;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _location = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text("Upload Lorry Photos"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                SizedBox(height: 16),
                
                if (_photos.isNotEmpty)
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _photos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _photos[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _photos.removeAt(index);
                                      _photoBytes.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                
                SizedBox(height: 24),
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
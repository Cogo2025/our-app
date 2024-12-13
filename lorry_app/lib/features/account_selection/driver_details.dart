import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../home_page/driver_home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverDetailsScreen extends StatefulWidget {
  @override
  _DriverDetailsScreenState createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  DateTime? dob;
  String gender = '';
  String phoneNumber = '';
  String licenseNumber = '';
  String email = ''; // New Email Field
  String password = ''; // New Password Field

  File? _image;

  TextEditingController dobController = TextEditingController();

  final _picker = ImagePicker();

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    final url = Uri.parse('http://localhost:5000/api/driver/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'dob': dob.toString(),
          'gender': gender,
          'phoneNumber': phoneNumber,
          'licenseNumber': licenseNumber,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print('Driver registered successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DriverHomePage()),
        );
      } else {
        print('Failed to register: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error occurred during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }
}


  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Driver Name Field
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  onSaved: (value) => name = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Date of Birth Field
                TextFormField(
                  decoration: InputDecoration(labelText: "Date of Birth"),
                  controller: dobController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null && selectedDate != dob) {
                      setState(() {
                        dob = selectedDate;
                        dobController.text = '${dob!.toLocal()}'
                            .split(' ')[0]; // Format the date
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Gender Field
                DropdownButtonFormField<String>(
                  value: gender.isEmpty ? null : gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  items: ['Male', 'Female', 'Other']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  decoration: InputDecoration(labelText: "Gender"),
                ),
                const SizedBox(height: 16),

                // Phone Number Field
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => phoneNumber = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // License Number Field
                TextFormField(
                  decoration: InputDecoration(labelText: "License Number"),
                  onSaved: (value) => licenseNumber = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your license number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Address Field
                TextFormField(
                  decoration: InputDecoration(labelText: "Email Address"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => email = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onSaved: (value) => password = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Photo Capture Section
                Text(
                  "Click to Take Photo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _takePhoto,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _image == null
                        ? Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 50,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

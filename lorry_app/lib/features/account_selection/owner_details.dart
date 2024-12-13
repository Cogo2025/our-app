import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lorry_app/core/theme/light_theme.dart';
import '../home_page/owner_home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OwnerDetailsPage extends StatefulWidget {
  @override
  _OwnerDetailsPageState createState() => _OwnerDetailsPageState();
}

class _OwnerDetailsPageState extends State<OwnerDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  DateTime? dob;
  String gender = '';
  String phoneNumber = '';
  String cinNumber = '';
  String email = ''; 
  String password = '';

  File? _image;

  final _picker = ImagePicker();

  final TextEditingController dobController = TextEditingController(); // Add a controller for dob input

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.parse('http://localhost:5000/api/owner/register');

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'dob': dob != null ? dob!.toIso8601String() : "", // ISO format for date
            'gender': gender,
            'phoneNumber': phoneNumber,
            'CINNumber': cinNumber,
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 201) {
          print('Owner registered successfully');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OwnerHomePage()),
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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera); // Switch to gallery if needed
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
      backgroundColor: lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Owner Details"),
        backgroundColor: lightTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
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
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    border: OutlineInputBorder(),
                  ),
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
                        dobController.text = '${dob!.toLocal()}'.split(' ')[0]; // Format the date
                      });
                    }
                  },
                  validator: (value) {
                    if (dob == null) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Gender Field
                DropdownButtonFormField<String>(
                  value: gender.isEmpty ? null : gender,
                  decoration: InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(),
                  ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone Number Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
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

                // CIN Number Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "CIN Number",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => cinNumber = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your CIN number';
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

                // Photo Section
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.grey[300],
                    child: _image == null
                        ? Text("Tap to take a photo")
                        : Image.file(_image!),
                  ),
                ),
                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightTheme.primaryColor,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

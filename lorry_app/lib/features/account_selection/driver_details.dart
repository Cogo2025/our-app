import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../home_page/driver_home_page.dart';


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

  TextEditingController dobController = TextEditingController();

  // Corrected _submitForm method with Navigator.pushReplacement
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Navigate to DriverHomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DriverHomePage()),
      );
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

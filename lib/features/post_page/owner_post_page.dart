import 'package:flutter/material.dart';

class _OwnerPostPageState extends State<OwnerPostPage> {
  // ... existing state variables and methods ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... existing scaffold code ...
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ... other form fields ...

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
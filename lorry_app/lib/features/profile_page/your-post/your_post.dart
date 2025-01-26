import 'dart:io';

import 'package:flutter/material.dart';

class YourPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments from the previous page
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Posts'),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          if (args.isNotEmpty) ...[
            Card(
              margin: EdgeInsets.all(10),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display selected photos
                  if (args['photos'] != null && args['photos'].isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: (args['photos'] as List<File>).map((file) {
                        return Image.file(
                          file,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Truck Type: ${args['truckType']}\n"
                      "BS Version: ${args['bsVersion']}\n"
                      "Driver Type: ${args['driverType']}\n"
                      "Time Duration: ${args['timeDuration']}\n"
                      "Location: ${args['location']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

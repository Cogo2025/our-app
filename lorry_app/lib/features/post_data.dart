library post_data;

import 'dart:io';

class Post {
  final String id;
  final String truckType;
  final String bsVersion;
  final String driverType;
  final String timeDuration;
  final String location;
  final List<String> photos;
  final String ownerId;

  Post({
    required this.id,
    required this.truckType,
    required this.bsVersion,
    required this.driverType,
    required this.timeDuration,
    required this.location,
    required this.photos,
    required this.ownerId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id']?.toString() ?? '',
      truckType: json['truckType']?.toString() ?? '',
      bsVersion: json['bsVersion']?.toString() ?? '',
      driverType: json['driverType']?.toString() ?? '',
      timeDuration: json['timeDuration']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      photos: (json['photos'] as List<dynamic>?)?.map((photo) => photo.toString()).toList() ?? [],
      ownerId: json['owner']?.toString() ?? '',
    );
  }
}

List<Map<String, dynamic>> ownerPosts = [];

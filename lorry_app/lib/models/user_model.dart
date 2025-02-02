class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String userType; // 'owner' or 'driver'
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.userType,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Debug log
    return User(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      userType: json['userType']?.toString() ?? '',
      profileImage: json['profileImage']?.toString(),
    );
  }
} 
// lib/utils/auth_token.dart
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken'); // Retrieves the stored token
}

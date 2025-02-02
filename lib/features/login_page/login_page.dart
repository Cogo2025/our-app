const String baseUrl = 'http://192.168.126.1:5000';  // Replace with your IP

Future<void> _login() async {
  try {
    setState(() {
      _isLoading = true;
    });

    print('Attempting login...'); // Debug print
    
    final response = await http.post(
      Uri.parse('$baseUrl/api/owner/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // ... rest of your login code ...
  } catch (e) {
    print('Login error: $e');
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Connection error. Please check server connection.')),
    );
  }
} 
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:p2/home.dart';

const String _baseURL = 'https://webhostwebhost186.000webhostapp.com';

Future<void> AddUsers(String name, String username, String password,
    BuildContext context) async {
  try {
    final url = Uri.parse('$_baseURL/signup.php');
    final response = await http.post(
      url,
      body: {
        'Name': name,
        'Username': username,
        'Password': password,
      },
    );
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()));// Assuming Home is your StatefulWidget
    } else {
      print('Failed to add address to the database');
    }
  } catch (e) {
      print('Error occurred while processing the request');
  }
}
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p2/home.dart';
import 'login_class.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObscure = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  Future<void> _login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    final cloudUrl = 'https://webhostwebhost186.000webhostapp.com/login.php';

    try {
      final response = await http.get(Uri.parse(cloudUrl));
      if (response.statusCode == 200) {
        List<dynamic> userData = json.decode(response.body);

        for (var userJson in userData) {
          final user = User.fromJson(userJson);

          if (user.username == username && user.password == password) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>const Home()));
            return;
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Incorrect username or password'),
                duration: Duration(seconds: 50),
              ),
            );
          }
        }

      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, e.g., display an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff1acb4d),
            Color(0xff184b28),
              ])),
              child: const Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  'Hello\nSign in!',
                  style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'UserName',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1acb4d),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                        ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                              },
                          ),
                          label: const Text(
                            'password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1acb4d),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(colors: [
                              Color(0xff1acb4d),
                              Color(0xff184b28),
                            ])),
                        child: TextButton(
                          onPressed:_login,
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Donot Have Account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => const Signup()));
                                  },
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}

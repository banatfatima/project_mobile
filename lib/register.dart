import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'login.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  Future<void> registerUser() async {
    final response = await http.post(
      Uri.parse("https://bariamikawi.000webhostapp.com/register.php"),
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passController.text,
      },
    );

    if (response.statusCode == 200) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('user_data', jsonEncode(jsonDecode(response.body)['user']));
      // Handle successful registration
      print("Registration successful");
      _navigateToLoginPage();
    } else {
      // Handle registration failure
      print("Registration failed");
    }
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AccountUs()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'SAFRA',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 46, 45, 45),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: ' AIRLINE',
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 93, 163),
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assests/a3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      SizedBox(height: 20),
                      Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          registerUser();
                        },
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 54, 171, 244),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                      ),
                    ])))));
  }
}

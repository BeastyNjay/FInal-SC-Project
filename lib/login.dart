import 'package:audio_reacts/firebase_auth.dart';
import 'package:audio_reacts/home_page.dart';
import 'package:flutter/material.dart';
import 'package:audio_reacts/signup.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Display a success message with custom color
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome Back',
            style: TextStyle(color: Color.fromARGB(255, 223, 227, 33)),
          ),
          backgroundColor: Color.fromARGB(255, 158, 17, 201),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                // Header with larger user icon
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Color(0xFF4CAF50),
                      child: Icon(Icons.person, color: Colors.white, size: 50.0),
                    ),
                  ),
                ),
                Spacer(),
                // Login Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await Authentication().Login(email: _usernameController.text, password: _passwordController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: Text('Login'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Text(
                            'Don\'t have an account? Sign up',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                // Footer with podium graphic
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: [
                      Text(
                        'The first three winners will get 1,000\$ in cash',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildPodiumStep(Colors.grey, '2nd', 100.0),
                          buildPodiumStep(Colors.yellow, '1st', 140.0),
                          buildPodiumStep(Colors.brown, '3rd', 80.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPodiumStep(Color color, String label, double height) {
    return Container(
      width: 50,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      color: color,
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

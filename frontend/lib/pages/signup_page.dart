import 'package:flutter/material.dart';
// import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ButtonStyle loginButtonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all<Color>(const Color.fromRGBO(42, 82, 81, 1)),
  );

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // You can use googleUser to get user details and implement your logic.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Acamedia',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        height: 70,
                        width: 350,
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: SizedBox(
                        height: 70,
                        width: 350,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your Email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: SizedBox(
                        height: 70,
                        width: 350,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: SizedBox(
                        height: 70,
                        width: 350,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      style: loginButtonStyle,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle login logic here
                          // e.g., authenticate user with backend
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          "or",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            _handleGoogleSignIn();
                          },
                          icon: Image.asset(
                            "lib/assets/google_icon.png",
                            height: 30.0,
                            width: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

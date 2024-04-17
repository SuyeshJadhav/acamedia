import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/pages/forgot_pass.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:frontend/services/user_service.dart';
import '../services/auth_service.dart';

// Styling constants
const EdgeInsets _inputFieldPadding = EdgeInsets.symmetric(
  horizontal: 10.0,
  vertical: 15.0,
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 221, 216, 1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'lib/assets/01.png',
                      height: 250,
                      width: 250,
                    ),
                    _buildAcamediaTitle(),
                    const SizedBox(height: 50),
                    _buildLoginForm(),
                    const SizedBox(height: 20),
                    _buildLoginButton(),
                    const SizedBox(height: 10),
                    _buildForgotPasswordLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAcamediaTitle() {
    return const Text(
      'Acamedia',
      style: TextStyle(fontSize: 25),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              contentPadding: _inputFieldPadding,
            ),
            validator: (value) {
              return null;

              // ... previous validation logic
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 25),
          child: TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              contentPadding: _inputFieldPadding,
            ),
            validator: (value) {
              return null;

              // ... previous validation logic
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(42, 82, 81, 1),
          fixedSize: const Size(90, 45),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: () =>
            _authenticate(_usernameController, _passwordController),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ));
  }

  Widget _buildForgotPasswordLink() {
    return GestureDetector(
      child: Text(
        'Forgot password',
        style: TextStyle(
            fontSize: 13.0,
            color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotPassPage(),
        ),
      ),
    );
  }

  void _authenticate(
      TextEditingController username, TextEditingController password) async {
    await AuthService.authenticate(username, password).then((value) => {
          if (value != null)
            {
              HelperFunctions.setLoggedInStatus(true),
              HelperFunctions.setUserId(value),
              userService.fetchUserData(value).then((data) async => {
                    if (data != null)
                      {
                        await HelperFunctions.setUserData(data),
                        await ChatService.fetchOtherUsers().then((chatList) => {
                              if (chatList != null)
                                {
                                  HelperFunctions.setChatData(chatList),
                                  _pageRoute(value),
                                }
                            })
                      }
                  }),
            }
          else
            print('No user id found')
        });
  }

  void _pageRoute(String userId) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userId: userId,
                )));
  }
}

import 'package:flutter/material.dart';

const EdgeInsets _inputFieldPadding = EdgeInsets.symmetric(
  horizontal: 10.0,
  vertical: 15.0,
);

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoginForm(),
                    const SizedBox(height: 20),
                    _buildChangePassButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
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
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 25),
          child: TextFormField(
            controller: _newPasswordController,
            decoration: const InputDecoration(
              labelText: 'New Password',
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

  Widget _buildChangePassButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(42, 82, 81, 1),
          fixedSize: const Size(100, 45),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: _changePassword,
        child: const Text(
          'Update',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ));
  }

  void _changePassword() async {
    // final String uri, username, password, userId;
    // username = _usernameController.text;
    // password = _passwordController.text;

    // uri = 'http://10.0.2.2:8000/api/user/login';
    // final url = Uri.parse(uri);
    // try {
    //   final res = await http.post(url,
    //       headers: {'Content-Type': 'application/json'},
    //       body: jsonEncode({'email': username, 'password': password}));

    //   final body = jsonDecode(res.body);
    //   userId = body['userId'];
    //   _pageRoute(userId);
    // } catch (e) {
    //   print('Error during auth: $e');
    // }
  }
}

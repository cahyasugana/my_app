import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:my_app/FrontEnd/elements/components/button.dart';
import 'package:my_app/FrontEnd/elements/components/my_text_field.dart';
import 'package:my_app/PinjamNada/endpoints/endpoints.dart';
import 'package:my_app/main.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> sendRegister(BuildContext context) async {
    final username = _usernameController.text;
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final password = _passwordController.text;

    if (username.isEmpty || fullName.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      debugPrint("All fields are required");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    final url = Uri.parse(Endpoints.register);
    final response = await http.post(
      url,
      body: {
        'username': username,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      // Handle successful registration
      debugPrint("Registration successful");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration successful")),
      );
      Navigator.pop(context); // Pop the screen on successful registration
    } else {
      // Handle registration failure
      debugPrint("Registration failed: ${response.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: ${response.statusCode}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                AssetImageWidget(
                  imagePath: 'assets/images/logoPinjamNadaHitam.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  namaApp,
                  style: GoogleFonts.manrope(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                MyTextField(
                  controller: _usernameController,
                  hintText: 'Enter your username',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: _fullNameController,
                  hintText: 'Enter your full name',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: _phoneController,
                  hintText: 'Enter your phone number',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ButtonSatu(
                  childColor: secondary,
                  buttonText: 'Register',
                  onPressed: () {
                    sendRegister(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/FrontEnd/elements/components/button.dart';
import 'package:my_app/FrontEnd/elements/components/my_text_field.dart';
import 'package:my_app/main.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Login extends StatelessWidget {
const Login({super.key});

  // Function to validate login credentials
void _validateLogin(BuildContext context) {
  // Menentukan username dan password yang diperbolehkan
  String validUsername = 'Danan';
  String validPassword = 'Danan123';

  // Mengambil nilai dari controller
  String username = usernameController.text.trim();
  String password = passwordController.text.trim();

  // Melakukan validasi
  if (username.isEmpty || password.isEmpty) {
    // Menampilkan pesan kesalahan jika username atau password kosong
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter username and password'),
      ),
    );
  } else if (username != validUsername || password != validPassword) {
    // Menampilkan pesan kesalahan jika username atau password tidak sesuai
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid username or password'),
      ),
    );
  } else {
    Navigator.pushReplacementNamed(context, '/navi');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const AssetImageWidget(
                  imagePath: 'assets/images/Logo.png',
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
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    controller: usernameController,
                    hintText: 'Enter your username',
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),
                ButtonSatu(
                  buttonText: 'Login',
                  onPressed: () {
                    _validateLogin(context);
                  },
                ), // ElevatedButton(onPressed:, child: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

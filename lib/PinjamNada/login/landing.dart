// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:my_app/FrontEnd/elements/components/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/main.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const AssetImageWidget(
                imagePath: 'assets/images/Logo.png',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              Text(
                namaApp,
                style: GoogleFonts.manrope(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonSatu(
                buttonText: 'Login',
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
              const SizedBox(
                height: 10,
              ),
              const ButtonSatu(
                buttonText: 'Sign Up',
                backgroundColor: bases,
                childColor: primary,
                borderColor: primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

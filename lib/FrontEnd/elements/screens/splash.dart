import 'package:flutter/material.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/main.dart';

class SplashScreen extends StatelessWidget {
  final Widget destinationWidget;

  SplashScreen({required this.destinationWidget});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => destinationWidget),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ), // Ganti dengan nama file logo Anda
      ),
    );
  }
}

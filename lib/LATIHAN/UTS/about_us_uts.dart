import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/FotoFormal.png'), // Ganti dengan path foto Anda
              ),
              SizedBox(height: 20),
              Text(
                'Nama: I Gede Danan Aria Satwika Punia',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'NIM: 2215091039',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Kelas: 4C',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
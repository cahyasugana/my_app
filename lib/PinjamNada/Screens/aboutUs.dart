import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Color(0xFF5C88C4),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Color(0xFF5C88C4),
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logoPinjamNadaPutih.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'PINJAM NADA',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Aplikasi Peminjaman Alat Musik',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Kami',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C88C4),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pinjam Nada adalah aplikasi yang memudahkan Anda dalam meminjam alat musik. Kami menyediakan berbagai jenis alat musik berkualitas untuk berbagai kebutuhan, mulai dari latihan, pertunjukan, hingga rekaman.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mengapa Memilih Pinjam Nada?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C88C4),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildFeature('Mudah digunakan'),
                  _buildFeature('Pilihan alat musik yang beragam'),
                  _buildFeature('Kualitas alat musik terjamin'),
                  _buildFeature('Proses peminjaman yang cepat'),
                  _buildFeature('Harga sewa yang terjangkau'),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              color: Color(0xFF5C88C4),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.email, color: Colors.white),
                        onPressed: () {
                          // Aksi ketika tombol email ditekan
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.phone, color: Colors.white),
                        onPressed: () {
                          // Aksi ketika tombol telepon ditekan
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.web, color: Colors.white),
                        onPressed: () {
                          // Aksi ketika tombol website ditekan
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Color(0xFF5C88C4)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center( // Pusatkan konten dalam layar
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Simetri di tengah
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/avatar.png'), // Ganti dengan path gambar avatar
              ),
              SizedBox(height: 20.0),
              ProfileInfoItem(label: 'User ID', value: '12345'), // Ganti dengan user ID sesuai
              ProfileInfoItem(label: 'Username', value: 'john_doe'), // Ganti dengan username sesuai
              ProfileInfoItem(label: 'Email', value: 'john@example.com'), // Ganti dengan email sesuai
              ProfileInfoItem(label: 'Password', value: '********'), // Ganti dengan password sesuai
              ProfileInfoItem(label: 'Contact', value: '+1234567890'), // Ganti dengan kontak sesuai
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Simetri di tengah
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.0),
        Text(
          value,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}

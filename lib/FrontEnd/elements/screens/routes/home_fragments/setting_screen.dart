// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //variable
  int _count = 0;

  //method
  // final String imageUrl = 'https://picsum.photos/250?image=9';

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    if (_count > 0) {
      setState(() {
        _count--;
      });
    }
  }

  // void _multiply() {
  //     setState(() {
  //       _count= _count * 2;
  //     });
  // }

  // _GanjilGenap(){
  //   if (_count % 2 == 0){
  //     return 'Genap';
  //   } else return 'Ganjil';
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
           const AssetImageWidget(
              imagePath: 'assets/images/SS_Angga.png',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          const Divider(),
          const Row(
            children: [
              Text('Test cui'),
            ]
          ),
          Row(
            children: [
              IconButton(onPressed: _increment, icon: const Icon(Icons.thumb_up)),
              IconButton(onPressed: _decrement, icon: const Icon(Icons.thumb_down)),
              Text('$_count Like'),
              IconButton(onPressed: _reset, icon: const Icon(Icons.restore)),
            ],
          )
        ],
      ),
    );
  }
}

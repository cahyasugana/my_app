import 'package:flutter/material.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:my_app/FrontEnd/elements/components/text_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void goToAnotherRoute(context, screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    // Navigator.pushNamed(context, '/second-screen');
  }

  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Text('Navigate to Screen Profile'),
    // );
    return const Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('Danan'), Text('Danan2'), Text('Danan3')],
          ),
          Card(
            color: Colors.amber,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            borderOnForeground: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('test'), Text('test')],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [Text('Test 1'), Text('Test 2')]),
              Column(children: [Text('Test 1'), Text('Test 2')])
            ],
          ),
          Divider(),
          Card(
            // ... other card properties like child, margin, etc.
            child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Test 1'), Text('Test 2')],
                )),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextContainer(
                text: 'Column 1',
                color: Colors.red,
                key: ValueKey(1),
              ),
              TextContainer(
                  text: 'Column 2', color: Colors.green, key: ValueKey(2)),
              TextContainer(
                  text: 'Column 3', color: Colors.blue, key: ValueKey(3)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              AssetImageWidget(
                imagePath: 'assets/images/icon_flutter.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            ],
          )
        ],
      ),
    );
  }
}

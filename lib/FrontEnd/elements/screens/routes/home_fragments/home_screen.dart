// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/FrontEnd/elements/screens/routes/home_fragments/menu_screen.dart';
import 'package:my_app/dto/appDTO.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<MenuItem> menuItems = [
    MenuItem(
      image: const AssetImage('assets/images/food1.jpg'),
      title: 'Grilled Salmon',
      description: 'Freshly grilled salmon served with vegetables.',
      price: 20000,
    ),
    MenuItem(
      image: const AssetImage('assets/images/food2.png'),
      title: 'Margherita Pizza',
      description: 'Classic margherita pizza with tomato and mozzarella.',
      price: 20000,
    ),
    MenuItem(
      image: const AssetImage('assets/images/food3.png'),
      title: 'Caesar Salad',
      description: 'Crisp romaine lettuce with Caesar dressing and croutons.',
      price: 20000,
    ),
    MenuItem(
      image: const AssetImage('assets/images/food4.png'),
      title: 'Pasta Carbonara',
      description: 'Spaghetti with creamy carbonara sauce and bacon bits.',
      price: 20000,
    ),
    MenuItem(
      image: const AssetImage('assets/images/food4.png'),
      title: 'Pasta Carbonara',
      description: 'Spaghetti with creamy carbonara sauce and bacon bits.',
      price: 20000,
    ),
    MenuItem(
      image: const AssetImage('assets/images/food4.png'),
      title: 'Pasta Carbonara',
      description: 'Spaghetti with creamy carbonara sauce and bacon bits.',
      price: 20000,
    ),
    MenuItem(
      image: const AssetImage('assets/images/food4.png'),
      title: 'Pasta Carbonara',
      description: 'Spaghetti with creamy carbonara sauce and bacon bits.',
      price: 20000,
    ),
    MenuItem(
      image: const AssetImage('assets/images/food4.png'),
      title: 'Pasta Carbonara',
      description: 'Spaghetti with creamy carbonara sauce and bacon bits.',
      price: 20000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = [
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage('assets/images/food1.jpg'),
            fit: BoxFit.cover, // Sesuaikan dengan kebutuhanmu
          ),
        ),
      ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage('assets/images/food2.png'),
            fit: BoxFit.cover, // Sesuaikan dengan kebutuhanmu
          ),
        ),
      ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage('assets/images/food3.png'),
            fit: BoxFit.cover, // Sesuaikan dengan kebutuhanmu
          ),
        ),
      ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage('assets/images/food4.png'),
            fit: BoxFit.cover, // Sesuaikan dengan kebutuhanmu
          ),
        ),
      ),
    ];

    return Center(
      child: Column(
        children: <Widget>[
          const Row(
            children: [
              SizedBox(
                width: 8,
                height: 58,
              ),
              Text(
                'Special Offer',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          CarouselSlider.builder(
            itemCount: carouselItems.length,
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return carouselItems[index];
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 14, top: 14, left: 8),
                child: Text(
                  'Our Menu',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuScreen(menuItems: menuItems),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    'Lihat semua',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: menuItems[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    menuItems[index].title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    menuItems[index].description,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

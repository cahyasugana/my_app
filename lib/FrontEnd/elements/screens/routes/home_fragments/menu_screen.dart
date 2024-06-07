import 'package:flutter/material.dart';
import 'package:my_app/dto/appDTO.dart';

class MenuScreen extends StatefulWidget {
  final List<MenuItem> menuItems;

  const MenuScreen({Key? key, required this.menuItems}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late List<MenuItem> filteredMenuItems;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredMenuItems = widget.menuItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: true, // Show back button automatically
              centerTitle: true,
              title: const Text('Menu'),
              floating: true,
              snap: true,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(
                   40.0), // Adjust height according to AppBar + SearchBox height
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Cari menu...',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filteredMenuItems = widget.menuItems
                                .where((menuItem) => menuItem.title
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Row(
                    //       children: [
                    //         FilterButton(text: 'Filter 1'),
                    //         FilterButton(text: 'Filter 2'),
                    //         FilterButton(text: 'Filter 3'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return buildMenuItemCard(context, filteredMenuItems[index]);
                },
                childCount: filteredMenuItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItemCard(BuildContext context, MenuItem menuItem) {
    return GestureDetector(
      onTap: () {
        // Implement onTap action here
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image(
                image: menuItem.image,
                fit: BoxFit.cover,
                height: 200, // Adjust image height as needed
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Rp. ${menuItem.price.toStringAsFixed(2)}', // Display price here
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      Colors.black.withOpacity(0.5), // Adjust opacity as needed
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuItem.title,
                      style: const TextStyle(
                        color: Colors.white, // Adjust text color as needed
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Adjust title font size
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      menuItem.description,
                      style: const TextStyle(
                        color: Colors.white, // Adjust text color as needed
                        fontSize: 16, // Adjust description font size
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;

  const FilterButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Implement filter action here
        },
        child: Text(text),
      ),
    );
  }
}

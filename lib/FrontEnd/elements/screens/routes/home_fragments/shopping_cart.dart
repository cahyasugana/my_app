import 'package:flutter/material.dart';
import 'package:my_app/dto/appDTO.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<MenuItem, int> cartItems = {
    MenuItem(
      image: const AssetImage('assets/images/food1.jpg'),
      title: 'Product 1',
      description: 'Description of Product 1',
      price: 20000,
    ): 2, // Product 1, 2 items
    MenuItem(
      image: const AssetImage('assets/images/food1.jpg'),
      title: 'Product 3',
      description: 'Description of Product 3',
      price: 15000,
    ): 1, // Product 3, 1 item
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...cartItems.keys.map((item) {
              return CartItem(
                itemName: item.title,
                itemPrice: item.price,
                itemCount: cartItems[item]!,
                itemImage: item.image,
                onIncrease: () {
                  setState(() {
                    cartItems[item] = cartItems[item]! + 1;
                  });
                },
                onDecrease: () {
                  setState(() {
                    if (cartItems[item]! > 1) {
                      cartItems[item] = cartItems[item]! - 1;
                    } else {
                      cartItems.remove(item);
                    }
                  });
                },
                onDelete: () {
                  setState(() {
                    cartItems.remove(item);
                  });
                },
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Total: Rp. ${_calculateTotal()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement your checkout logic here
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateTotal() {
    int total = 0;
    for (var entry in cartItems.entries) {
      total += entry.key.price * entry.value;
    }
    return total.toString();
  }
}

class CartItem extends StatefulWidget {
  final String itemName;
  final int itemPrice;
  final int itemCount;
  final ImageProvider<Object> itemImage;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onDelete;

  const CartItem({
    required this.itemName,
    required this.itemPrice,
    required this.itemCount,
    required this.itemImage,
    this.onIncrease,
    this.onDecrease,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onDelete,
            icon: const Icon(Icons.delete),
          ),
          Image(image: widget.itemImage, width: 100, height: 200),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.itemName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp. ${widget.itemPrice.toString()}',
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: widget.onDecrease,
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      '${widget.itemCount}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    IconButton(
                      onPressed: widget.onIncrease,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

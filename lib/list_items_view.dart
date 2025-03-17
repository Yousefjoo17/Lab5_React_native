import 'package:flutter/material.dart';
import 'package:testapp/cart_view.dart';
import 'package:testapp/widgets/item_widget.dart';

class ListItemView extends StatefulWidget {
  const ListItemView({super.key});

  @override
  State<ListItemView> createState() => _ListItemViewState();
}

class _ListItemViewState extends State<ListItemView> {
  final List<Map<String, dynamic>> items = List.generate(12, (index) {
    return {
      'imagePath': "assets/images/item.jpg",
      'name': 'Item ${index + 1}',
      'price': (15.99 + (index * 2)),
    };
  });

  List<Map<String, dynamic>> cart = []; // Empty cart list

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage(cart: cart)),
                  );
                },
              ),
              if (cart.isNotEmpty) // Show cart count only if not empty
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ItemWidget(
              image_path: item['imagePath'],
              name: item['name'],
              price: item['price'],
              onAddToCart: () => addToCart(item),
            );
          },
        ),
      ),
    );
  }
}

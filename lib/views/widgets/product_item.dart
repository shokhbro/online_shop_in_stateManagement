import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lesson_44/controllers/cart_controller.dart';
import 'package:lesson_44/controllers/products_controller.dart';
import 'package:lesson_44/models/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  void _editProductDialog(BuildContext context, Product product,
      ProductsController productsController) {
    final titleController = TextEditingController(text: product.title);
    final priceController =
        TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newTitle = titleController.text;
              final newPrice =
                  double.tryParse(priceController.text) ?? product.price;
              final newColor = _generateRandomColor();

              final newProduct = Product(
                id: product.id,
                title: newTitle,
                price: newPrice,
                color: newColor,
              );

              setState(() {
                productsController.editProduct(product.id, newProduct);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final productsController =
        Provider.of<ProductsController>(context, listen: true);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: product.color,
      ),
      title: Text(
        product.title,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text("\$${product.price}"),
      trailing: Consumer<CartController>(
        builder: (context, controller, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _editProductDialog(context, product, productsController);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  productsController.deleteProduct(product.id);
                },
                icon: const Icon(Icons.delete),
              ),
              if (!controller.isInCart(product.id))
                IconButton(
                  onPressed: () {
                    controller.addToCart(product);
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.removeFromCart(product.id);
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Text(
                      controller.getProductAmount(product.id).toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.addToCart(product);
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

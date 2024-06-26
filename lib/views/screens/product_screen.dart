import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lesson_44/controllers/products_controller.dart';
import 'package:lesson_44/models/product.dart';
import 'package:lesson_44/views/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductsController>(
      create: (context) => ProductsController(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: const Text("Mahsulotlar"),
        ),
        body: Consumer<ProductsController>(
          builder: (context, controller, child) {
            return ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (ctx, index) {
                final product = controller.list[index];
                return ChangeNotifierProvider<Product>.value(
                  value: product,
                  child: const ProductItem(),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addProductDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addProductDialog(BuildContext context) {
    final productsController =
        Provider.of<ProductsController>(context, listen: false);
    final titleController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Product'),
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
              final newPrice = double.tryParse(priceController.text) ?? 0.0;
              final newColor = _generateRandomColor();

              final newProduct = Product(
                id: UniqueKey().toString(),
                title: newTitle,
                price: newPrice,
                color: newColor,
              );

              setState(() {
                productsController.addProduct(newProduct);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Add'),
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
}

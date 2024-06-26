import 'package:flutter/material.dart';
import 'package:lesson_44/models/product.dart';

class ProductsController extends ChangeNotifier {
  final List<Product> _list = [
    Product(
      id: UniqueKey().toString(),
      title: "iPhone",
      color: Colors.teal,
      price: 340.5,
    ),
    Product(
      id: UniqueKey().toString(),
      title: "Macbook",
      color: Colors.grey,
      price: 1340.5,
    ),
    Product(
      id: UniqueKey().toString(),
      title: "AirPods",
      color: Colors.blue,
      price: 140.5,
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  void addProduct(Product product) {
    _list.add(product);
    notifyListeners(); // Notify listeners to update UI
  }

  void editProduct(String id, Product newProduct) {
    final index = _list.indexWhere((product) => product.id == id);
    if (index != -1) {
      _list[index] = newProduct;
      notifyListeners(); // Notify listeners to update UI
    }
  }

  void deleteProduct(String id) {
    _list.removeWhere((product) => product.id == id);
    notifyListeners(); // Notify listeners to update UI
  }
}

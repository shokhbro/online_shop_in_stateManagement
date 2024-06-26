import 'package:flutter/material.dart';
import 'package:lesson_44/controllers/cart_controller.dart';
import 'package:lesson_44/controllers/products_controller.dart';
import 'package:lesson_44/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartController()),
        ChangeNotifierProvider(create: (ctx) => ProductsController()),
      ],
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}

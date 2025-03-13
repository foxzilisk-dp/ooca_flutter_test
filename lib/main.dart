import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'foodOrderScreen.dart';

void main() {
  runApp(const FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  const FoodOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false, // Disables the debug banner
      home: const FoodOrderScreen(),
      // Optionally, define routes here for easier navigation as the app grows.
      // routes: {
      //   '/home': (context) => FoodStoreScreen(),
      //   '/anotherScreen': (context) => AnotherScreen(),
      // },
    );
  }
}

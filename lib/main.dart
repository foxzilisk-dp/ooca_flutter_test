import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/order_screen.dart';

void main() {
  runApp(const OrderApp());
}

class OrderApp extends StatelessWidget {
  const OrderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.yellow.shade700,
      ),
      debugShowCheckedModeBanner: false,
      home: OrderScreen(),
    );
  }
}

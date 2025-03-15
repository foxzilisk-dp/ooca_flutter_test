import 'package:flutter/material.dart';

// Define menu item model
class MenuItem {
  final String name;
  final double price;
  final Color color;

  MenuItem({required this.name, required this.price, required this.color});

  @override
  String toString() {
    return 'MenuItem(name: $name, price: $price, color: $color)';
  }
}

// Define menu items
final List<MenuItem> menuItems = [
  MenuItem(name: "Red Set", price: 50, color: Colors.redAccent.shade700),
  MenuItem(name: "Green Set", price: 40, color: Colors.green),
  MenuItem(name: "Blue Set", price: 30, color: Colors.blue),
  MenuItem(name: "Yellow Set", price: 50, color: Colors.yellow.shade700),
  MenuItem(name: "Pink Set", price: 80, color: Colors.pinkAccent.shade200),
  MenuItem(name: "Purple Set", price: 90, color: Colors.purple),
  MenuItem(name: "Orange Set", price: 120, color: Colors.deepOrange.shade400),
];

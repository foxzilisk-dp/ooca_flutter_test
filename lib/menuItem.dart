import 'package:flutter/material.dart';

class MenuItem {
  final String set;
  final int price;
  final Color color;

  MenuItem(this.set, this.price, this.color);
}

final List<MenuItem> menuItems = [
  MenuItem("Red set", 50, Colors.red),
  MenuItem("Green set", 40, Colors.green),
  MenuItem("Blue set", 30, Colors.blue),
  MenuItem("Yellow set", 50, Colors.yellow),
  MenuItem("Pink set", 80, Colors.pink),
  MenuItem("Purple set", 90, Colors.purple),
  MenuItem("Orange set", 120, Colors.orange),
];

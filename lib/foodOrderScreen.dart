import 'package:flutter/material.dart';

class FoodOrderScreen extends StatefulWidget {
  const FoodOrderScreen({super.key});

  @override
  FoodOrderScreenState createState() => FoodOrderScreenState();
}

class FoodOrderScreenState extends State<FoodOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Order")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double iconSize = constraints.maxWidth * 0.1;
          double fontSize = constraints.maxWidth * 0.05;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: const BoxDecoration(
                          color: Colors.amberAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text("set",
                          style: TextStyle(fontSize: fontSize * 0.8)),
                      subtitle: Text("10 THB/set",
                          style: TextStyle(fontSize: fontSize * 0.7)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, size: fontSize * 0.8),
                            onPressed: () => {},
                          ),
                          Text("0", style: TextStyle(fontSize: fontSize * 0.8)),
                          IconButton(
                            icon: Icon(Icons.add, size: fontSize * 0.8),
                            onPressed: () => {},
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              CheckboxListTile(
                title: Text("Use Member Card (10% Discount)",
                    style: TextStyle(fontSize: fontSize * 0.8)),
                value: true,
                onChanged: (value) {},
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Total Price: xx THB",
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

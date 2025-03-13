import 'package:flutter/material.dart';
import 'menuItem.dart';

class FoodOrderScreen extends StatefulWidget {
  const FoodOrderScreen({super.key});

  @override
  FoodOrderScreenState createState() => FoodOrderScreenState();
}

class FoodOrderScreenState extends State<FoodOrderScreen> {
  bool hasMemberCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 Column
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // responsive card view
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.blue[300],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          // images
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: item.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // set name
                          Text(
                            item.set,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // price
                          Text(
                            "${item.price} THB",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          // + and - order set
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () => {},
                              ),
                              const Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.blueAccent),
                                  onPressed: () => {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CheckboxListTile(
              title: const Text(
                "Use Member Card \n(10% Discount)",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              value: hasMemberCard,
              onChanged: (value) {
                setState(() {
                  hasMemberCard = value!;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Total Price: xx THB",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

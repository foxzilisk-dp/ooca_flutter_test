import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart'; // Import the OrderController
import '../models/menu_item.dart'; // Import the MenuItem model

class OrderScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Menu', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Check if there's no page to pop, show exit confirmation dialog
            if (Navigator.canPop(context)) {
              Get.back(); // Go back to the previous screen
            } else {
              _showExitConfirmationDialog(context); // Show exit dialog
            }
          },
        ),
        actions: [
          // Reset Button as an Icon in the AppBar
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              orderController.resetOrder();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Expanded Column: Two-column menu grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getColumnCount(
                    context), // Adjust number of columns based on screen size
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];
                return Card(
                  color: menuItem.color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circle with white border above the name
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child:
                            Icon(Icons.fastfood, color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        menuItem.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '\$${menuItem.price}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              orderController.updateOrder(menuItem.name, -1);
                            },
                          ),
                          Obx(() {
                            final quantity =
                                orderController.getItemQuantity(menuItem.name);
                            return Text(
                              '$quantity',
                              style: const TextStyle(color: Colors.white),
                            );
                          }),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              orderController.updateOrder(menuItem.name, 1);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Member card
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // จัดข้อความและปุ่มให้ห่างกัน
                children: [
                  Expanded(
                    child: Text(
                      orderController.hasMemberCard.value
                          ? 'Use member card 10% discount'
                          : 'No member card',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Obx(() => Material(
                          color: orderController.hasMemberCard.value
                              ? Colors.green
                              : Colors.blue.shade300,
                          shape: CircleBorder(),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              orderController.toggleMemberCard(
                                  !orderController.hasMemberCard.value);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                orderController.hasMemberCard.value
                                    ? Icons.card_membership
                                    : Icons.card_giftcard,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    onPressed: () {
                      orderController.toggleMemberCard(
                          !orderController.hasMemberCard.value);
                    },
                  ),
                ],
              );
            }),
          ),

          // Total Price Display
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // จัดให้ข้อความและปุ่มห่างกัน
              children: [
                Expanded(
                  child: Text(
                    'Total Price: ${orderController.totalPrice.toStringAsFixed(2)} THB',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Material(
                  color: _isClicked ? Colors.green : Colors.blue.shade300,
                  shape: CircleBorder(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      _isClicked = true;
                      Get.snackbar(
                        'Payment',
                        'Payment has been made successfully.',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                        isDismissible: true,
                      );

                      Future.delayed(Duration(seconds: 2), () {
                        // เมื่อ snackbar หายไปแล้ว ให้รีเซตค่าต่างๆ
                        _isClicked = false;
                        orderController.hasMemberCard.value =
                            false; // รีเซตสถานะของ member card
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.payment,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // bottomSheet: Container(
      //   color: Colors.blue, // Set color to match app bar
      //   padding: const EdgeInsets.symmetric(vertical: 8),
      //   child: Center(
      //     child: Text(
      //       'Thanks for using our app!',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
    );
  }

  // Get column count based on screen size (responsive layout)
  int _getColumnCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return 2; // For mobile, 2 columns
    } else if (width < 1200) {
      return 3; // For tablet, 3 columns
    } else {
      return 4; // For large screens (desktop), 4 columns
    }
  }

  // Function to show confirmation dialog when attempting to exit the app
  void _showExitConfirmationDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              Get.close(2); // Exit the app
            },
            child: const Text('Yes', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}

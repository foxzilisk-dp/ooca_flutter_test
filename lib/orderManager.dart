import 'package:get/get.dart';

// Your existing controller (OrderController)
class OrderController extends GetxController {
  var order = <String, int>{}.obs; // Observable map for order items
  var hasMemberCard = false.obs; // Observable for member card status

  // Method to update quantity of an item
  void updateOrder(String name, int change) {
    if (!order.containsKey(name)) {
      order[name] = 0;
    }
    order[name] = (order[name]! + change).clamp(0, double.infinity).toInt();
    if (order[name] == 0) {
      order.remove(name);
    }
  }

  // Get the quantity of an item
  int getItemQuantity(String name) {
    return order[name] ?? 0;
  }

  // Toggle the member card status
  void toggleMemberCard(bool value) {
    hasMemberCard.value = value;
  }

  // Calculate total price with member discount if applicable
  double get totalPrice {
    double total = 0;
    for (var entry in order.entries) {
      total += entry.value * 50.0; // Assuming 50 THB per item for simplicity
    }
    if (hasMemberCard.value) {
      total *= 0.90; // Apply 10% discount if member card is active
    }
    return total;
  }

  // Reset the order to initial state
  void resetOrder() {
    order.clear();
    hasMemberCard.value = false;
  }
}

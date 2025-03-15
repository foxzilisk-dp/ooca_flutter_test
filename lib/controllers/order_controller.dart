import 'package:get/get.dart';
import '../models/menu_item.dart'; // Import the menu items data

class OrderController extends GetxController {
  var order = <String, int>{}.obs; // Observable map for order items
  var hasMemberCard = false.obs; // Observable for member card status

  // Map of menu items keyed by their names for efficient lookup
  final Map<String, MenuItem> _menuItemMap = {
    for (var item in menuItems) item.name: item
  };

  // Method to update quantity of an item
  void updateOrder(String name, int change) {
    if (!order.containsKey(name)) {
      order[name] = 0;
    }
    order[name] =
        (order[name]! + change).clamp(0, 100); // Limited to a max of 100 items
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
    bool hasDiscountOnSpecialItems = false;

    // Loop through each order item
    for (var entry in order.entries) {
      var menuItem = _menuItemMap[entry.key]; // Use the lookup map
      if (menuItem != null) {
        total +=
            entry.value * menuItem.price; // Use the actual price of the item

        // Check for special items (Orange, Pink, Green sets)
        if (['Orange Set', 'Pink Set', 'Green Set'].contains(entry.key)) {
          // If quantity is 2 or more, apply the 5% discount condition
          if (entry.value >= 2) {
            hasDiscountOnSpecialItems = true;
          }
        }
      }
    }

    // Apply 5% discount for special items (Orange, Pink, Green) when applicable
    if (hasDiscountOnSpecialItems) {
      total *= 0.95; // Apply 5% discount on special items
    }

    // Apply 10% discount if member card is active
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

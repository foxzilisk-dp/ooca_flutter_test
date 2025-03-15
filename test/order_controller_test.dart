import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:food_store_app/controllers/order_controller.dart';

void main() {
  late OrderController orderController;

  setUp(() {
    orderController = OrderController();
  });

  group('OrderController Test', () {
    test('Initial order should be empty', () {
      expect(orderController.order.isEmpty, true);
      expect(orderController.hasMemberCard.value, false);
    });

    test('Adding items should update order quantity', () {
      orderController.updateOrder("Red Set", 1);
      expect(orderController.getItemQuantity("Red Set"), 1);

      orderController.updateOrder("Red Set", 2);
      expect(orderController.getItemQuantity("Red Set"), 3);
    });

    test('Removing items should decrease order quantity', () {
      orderController.updateOrder("Blue Set", 3);
      orderController.updateOrder("Blue Set", -1);
      expect(orderController.getItemQuantity("Blue Set"), 2);
    });

    test('Removing all quantity should remove item from order', () {
      orderController.updateOrder("Yellow Set", 2);
      orderController.updateOrder("Yellow Set", -2);
      expect(orderController.order.containsKey("Yellow Set"), false);
    });

    test('Member card toggle should work', () {
      orderController.toggleMemberCard(true);
      expect(orderController.hasMemberCard.value, true);

      orderController.toggleMemberCard(false);
      expect(orderController.hasMemberCard.value, false);
    });

    test('Total price calculation without discounts', () {
      orderController.updateOrder("Red Set", 1);  // 50 THB
      orderController.updateOrder("Green Set", 2); // 40 x 2 = 80 THB
      expect(orderController.totalPrice, 130.0);
    });

    test('Total price with 10% member discount', () {
      orderController.updateOrder("Red Set", 1);
      orderController.updateOrder("Green Set", 1);
      orderController.toggleMemberCard(true);

      double expectedTotal = (50 + 40) * 0.90; // 90 - 10%
      expect(orderController.totalPrice, expectedTotal);
    });

    test('Discount for ordering 2+ of specific items (Orange, Pink, Green)', () {
      orderController.updateOrder("Orange Set", 2);
      orderController.updateOrder("Pink Set", 2);
      orderController.updateOrder("Green Set", 2);

      double baseTotal = (120 * 2) + (80 * 2) + (40 * 2); // 480 THB
      double expectedDiscount = baseTotal * 0.05; // 5% off

      expect(orderController.totalPrice, baseTotal - expectedDiscount);
    });

    test('Reset order should clear all data', () {
      orderController.updateOrder("Red Set", 2);
      orderController.updateOrder("Green Set", 1);
      orderController.toggleMemberCard(true);

      orderController.resetOrder();

      expect(orderController.order.isEmpty, true);
      expect(orderController.hasMemberCard.value, false);
    });
  });
}

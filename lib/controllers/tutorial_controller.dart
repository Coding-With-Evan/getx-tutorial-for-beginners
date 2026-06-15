import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product {
  const Product({required this.name, required this.price, required this.icon});

  final String name;
  final double price;
  final IconData icon;
}

class CounterController extends GetxController {
  final count = 0.obs;
  final milestones = <String>[].obs;

  String lessonStatus = 'GetBuilder has not rebuilt yet.';

  void increment() {
    count.value++;

    if (count.value % 5 == 0) {
      milestones.add('Milestone: ${count.value} reactive taps');
    }
  }

  void reset() {
    count.value = 0;
    milestones.clear();
  }

  void markLessonWatched() {
    lessonStatus =
        'GetBuilder rebuilt at ${TimeOfDay.now().format(Get.context!)}';
    update();
  }
}

class CartController extends GetxController {
  final products = const [
    Product(name: 'GetX Basics', price: 9, icon: Icons.school_outlined),
    Product(name: 'Routing Lesson', price: 12, icon: Icons.route_outlined),
    Product(name: 'DI Deep Dive', price: 15, icon: Icons.hub_outlined),
  ];

  final cart = <String, int>{}.obs;

  int get totalItems => cart.values.fold(0, (sum, quantity) => sum + quantity);

  double get totalPrice => products.fold(0, (sum, product) {
    final quantity = cart[product.name] ?? 0;
    return sum + product.price * quantity;
  });

  void add(Product product) {
    cart[product.name] = (cart[product.name] ?? 0) + 1;
  }

  void remove(Product product) {
    final currentQuantity = cart[product.name] ?? 0;

    if (currentQuantity <= 1) {
      cart.remove(product.name);
      return;
    }

    cart[product.name] = currentQuantity - 1;
  }

  void clear() {
    cart.clear();
  }
}

class SettingsController extends GetxController {
  final isDarkMode = false.obs;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}

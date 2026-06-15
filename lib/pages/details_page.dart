import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tutorial_controller.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final arguments = Get.arguments as Map<String, String>? ?? {};
    final title = arguments['title'] ?? 'Details Page';
    final message = arguments['message'] ?? 'No arguments were passed.';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Route Arguments',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(message),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_cart_checkout_outlined),
                title: const Text('Same CartController Instance'),
                subtitle: Text(
                  'The cart still has ${cartController.totalItems} item(s), proving Get.find reused the dependency.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              Get.back(result: 'Details page returned a success message.');
            },
            icon: const Icon(Icons.keyboard_return),
            label: const Text('Return Result to Home'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_routes.dart';
import '../controllers/tutorial_controller.dart';

class HomePage extends GetView<CounterController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final settingsController = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Tutorial Demo'),
        actions: [
          Obx(
            () => Row(
              children: [
                const Icon(Icons.dark_mode_outlined),
                Switch(
                  value: settingsController.isDarkMode.value,
                  onChanged: settingsController.toggleTheme,
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _IntroCard(),
          const SizedBox(height: 16),
          _SectionCard(
            number: '1',
            title: 'Reactive State with Obx',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tap the button and only this Obx area rebuilds when count changes.',
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Text(
                    '${controller.count.value}',
                    key: const Key('counterText'),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    FilledButton.icon(
                      key: const Key('incrementCounterButton'),
                      onPressed: controller.increment,
                      icon: const Icon(Icons.add),
                      label: const Text('Increment'),
                    ),
                    OutlinedButton.icon(
                      onPressed: controller.reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Text(
                    controller.milestones.isEmpty
                        ? 'Milestones appear every 5 taps.'
                        : controller.milestones.last,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            number: '2',
            title: 'Simple State with GetBuilder',
            child: GetBuilder<CounterController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.lessonStatus),
                    const SizedBox(height: 12),
                    FilledButton.tonalIcon(
                      onPressed: controller.markLessonWatched,
                      icon: const Icon(Icons.replay_outlined),
                      label: const Text('Rebuild GetBuilder'),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            number: '3',
            title: 'Dependency Injection with Get.find',
            child: Column(
              children: [
                for (final product in cartController.products)
                  _ProductTile(product: product),
                const Divider(),
                Obx(
                  () => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.shopping_cart_outlined),
                    title: Text('Cart items: ${cartController.totalItems}'),
                    subtitle: Text(
                      'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
                    ),
                    trailing: TextButton(
                      onPressed: cartController.clear,
                      child: const Text('Clear'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            number: '4',
            title: 'Navigation without BuildContext',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get.toNamed sends arguments and can return a result from the next screen.',
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  key: const Key('openDetailsButton'),
                  onPressed: () async {
                    final result = await Get.toNamed(
                      AppRoutes.details,
                      arguments: {
                        'title': 'GetX Named Routes',
                        'message':
                            'This screen received data using Get.arguments.',
                      },
                    );

                    if (result is String) {
                      Get.snackbar('Returned from details', result);
                    }
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open Details Page'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            number: '5',
            title: 'Snackbar and Dialog Helpers',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () {
                    Get.snackbar(
                      'Get.snackbar',
                      'No ScaffoldMessenger or context required.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  icon: const Icon(Icons.notifications_outlined),
                  label: const Text('Show Snackbar'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Get.defaultDialog',
                      middleText:
                          'This dialog is opened from anywhere using GetX.',
                      textConfirm: 'Nice',
                      onConfirm: Get.back,
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Show Dialog'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learn GetX by touching the features',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'This demo covers reactive state, GetBuilder, dependency injection, routes, snackbars, dialogs, and theme changes.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.number,
    required this.title,
    required this.child,
  });

  final String number;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text(number)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final quantity = cartController.cart[product.name] ?? 0;

      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(product.icon),
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            IconButton.filledTonal(
              onPressed: quantity == 0
                  ? null
                  : () => cartController.remove(product),
              icon: const Icon(Icons.remove),
            ),
            Text('$quantity'),
            IconButton.filled(
              onPressed: () => cartController.add(product),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      );
    });
  }
}

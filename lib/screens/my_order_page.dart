import 'package:flutter/material.dart';
import 'package:yummy/models/order_manager.dart';

class MyOrderManager extends StatelessWidget {
  final OrderManager orderManager;

  const MyOrderManager({super.key, required this.orderManager});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: textTheme.headlineMedium,
        ),
      ),
      body: ListView.builder(
          itemCount: orderManager.totalOrders,
          itemBuilder: (context, index) {
            return OrderTile(order: orderManager.orders[index]);
          }),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          'assets/food/burger.webp',
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Scheduled',
          style: textTheme.bodyLarge,
        ),
        Text(order.getFormattedOrderInfo()),
        // 12
        Text('Items: ${order.items.length}'),
      ]),
    );
  }
}

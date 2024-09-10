import 'package:flutter/material.dart';
import 'package:yummy/constants.dart';
import 'package:yummy/components/color_button.dart';
import 'package:yummy/components/theme_button.dart';
// import 'package:yummy/components/post_card.dart';
import 'package:yummy/screens/my_order_page.dart';

import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';
// import 'package:yummy/models/restaurant.dart';
// import 'package:yummy/components/restaurant_landscape_card.dart';
import 'package:yummy/screens/explore_page.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.selectedColor,
    required this.cartManager,
    required this.orderManager,
  });

  final CartManager cartManager;
  final OrderManager orderManager;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection selectedColor;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;

  List<NavigationDestination> appBarDestination = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Category',
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      icon: Icon(Icons.list_outlined),
      label: "Post",
      selectedIcon: Icon(Icons.list),
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      label: "Restaurant",
      selectedIcon: Icon(Icons.person_2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      Center(
        child: ExplorePage(
          cartManager: widget.cartManager,
          orderManager: widget.orderManager,
        ),
      ),
      MyOrderManager(orderManager: widget.orderManager),
      Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        // child: RestaurantLandscapeCard(restaurant: restaurants[0]),
      ))
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme),
          ColorButton(
              changeColor: widget.changeColor,
              colorSelected: widget.selectedColor)
        ],
      ),

      // TO DO: Switch between pages

      body: IndexedStack(index: tab, children: pages),

      bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (index) {
            setState(() {
              tab = index;
            });
          },
          destinations: appBarDestination),
    );
  }
}

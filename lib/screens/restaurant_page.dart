import 'package:flutter/material.dart';
import 'package:yummy/components/item_details.dart';
import 'package:yummy/components/restaurant_item.dart';
import 'package:yummy/models/order_manager.dart';
import 'package:yummy/models/restaurant.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/screens/checkout_page.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  final CartManager cartManager;
  final OrderManager orderManager;

  const RestaurantPage(
      {super.key,
      required this.restaurant,
      required this.cartManager,
      required this.orderManager});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  static const desktopThreshold = 700;
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;
  static const double drawerWidth = 375.0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  double _calculateConstrainedWidth(double screenWidth) {
    return (screenWidth > desktopThreshold
            ? screenWidth * largeScreenPercentage //
            : screenWidth)
        .clamp(0.0, maxWidth);
  }

  int calculateColumnCount(double screenWidth) {
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  CustomScrollView _buildCustomScrolView() {
    return CustomScrollView(
      slivers: [
        _buildSilverAppBar(),
        _builInfoSection(),
        _buildGridViewSection('Menu')
      ],
    );
  }

  SliverAppBar _buildSilverAppBar() {
    final theme = Theme.of(context).colorScheme;

    return SliverAppBar(
      backgroundColor: theme.background,
      pinned: true,
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 55.0,
          ),
          child: Stack(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(widget.restaurant.imageUrl),
                    fit: BoxFit.cover),
              ),
            ),
            const Positioned(
                bottom: 0.0,
                left: 16.0,
                child: CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.store,
                    color: Colors.white,
                  ),
                ))
          ]),
        ),
      ),
    );
  }

  SliverToBoxAdapter _builInfoSection() {
    final textTheme = Theme.of(context).textTheme;
    final restaurant = widget.restaurant;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: textTheme.headlineLarge,
            ),
            Text(
              restaurant.address,
              style: textTheme.bodySmall,
            ),
            Text(
              restaurant.getRatingAndDistance(),
              style: textTheme.bodySmall,
            ),
            Text(
              restaurant.attributes,
              style: textTheme.labelSmall,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    final item = widget.restaurant.items[index];
    return InkWell(
      onTap: () => _showBottomSheet(item),
      child: RestaurantItem(item: item),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  GridView _buildGridView(int columns) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) => _buildGridItem(index),
      itemCount: widget.restaurant.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  SliverToBoxAdapter _buildGridViewSection(String title) {
    final columns = calculateColumnCount(MediaQuery.of(context).size.width);

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_sectionTitle(title), _buildGridView(columns)]),
      ),
    );
  }

  void _showBottomSheet(Item item) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        constraints: const BoxConstraints(maxWidth: 480.0),
        builder: (context) => ItemDetails(
            cartManager: widget.cartManager,
            item: item,
            quatityUpdated: () {
              setState(() {
                () {};
              });
            }));
  }

  Widget _buildEndDrawer() {
    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: CheckoutPage(
          cartManager: widget.cartManager,
          didUpdate: () {
            setState(() {});
          },
          onSubmit: (order) {
            widget.orderManager.addOrder(order);
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
    );
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
  // TO DO: Create Floating Action Button

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: _buildEndDrawer(),
      floatingActionButton: _buildFloatingActionButton(),
      // TO DO: Apply Floating Action Button
      body: Center(
          child: SizedBox(
        width: constrainedWidth,
        child: _buildCustomScrolView(),
      )),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: openDrawer,
      tooltip: 'Cart',
      icon: const Icon(Icons.shopping_cart),
      label: Text('${widget.cartManager.items.length} Items in cart'),
    );
  }
}

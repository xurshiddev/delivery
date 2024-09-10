import 'package:flutter/material.dart';
import 'package:yummy/models/order_manager.dart';
import 'package:yummy/models/restaurant.dart';
import 'package:yummy/screens/restaurant_page.dart';
import 'package:yummy/models/cart_manager.dart';

class RestaurantLandscapeCard extends StatefulWidget {
  final Restaurant restaurant;
  final CartManager cartManager;
  final OrderManager orderManager;
  const RestaurantLandscapeCard(
      {super.key,
      required this.restaurant,
      required this.cartManager,
      required this.orderManager});

  @override
  State<RestaurantLandscapeCard> createState() =>
      _RestaurantLandscapeCardState();
}

class _RestaurantLandscapeCardState extends State<RestaurantLandscapeCard> {
  bool isFavarite = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
        child: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Column(children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: AspectRatio(
                      aspectRatio: 2,
                      child: Image(
                        image: AssetImage(widget.restaurant.imageUrl),
                        fit: BoxFit.cover,
                      )),
                ),
                ListTile(
                  title: Text(
                    widget.restaurant.name,
                    style: textTheme.titleSmall,
                  ),
                  subtitle: Text(
                    widget.restaurant.attributes,
                    style: textTheme.bodySmall,
                    maxLines: 2,
                  ),
                ),
              ]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RestaurantPage(
                              restaurant: widget.restaurant,
                              cartManager: widget.cartManager,
                              orderManager: widget.orderManager,
                            )));
              },
            )
          ],
        ),
        Positioned(
          top: 4.0,
          right: 4.0,
          child: IconButton(
              icon: Icon(
                isFavarite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  isFavarite = !isFavarite;
                });
              }),
        ),
      ],
    ));
  }
}

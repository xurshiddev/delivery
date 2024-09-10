import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yummy/components/cart_control.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/restaurant.dart';
// import 'package:yummy/components/item_details.dart';

class ItemDetails extends StatefulWidget {
  final Item item;
  final CartManager cartManager;
  final void Function() quatityUpdated;

  const ItemDetails({
    super.key,
    required this.cartManager,
    required this.item,
    required this.quatityUpdated,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    final colorTheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.name,
                style: textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 16.0,
              ),
              _mostLikeBadge(colorTheme),
              const SizedBox(
                height: 16.0,
              ),
              Text(widget.item.description),
              const SizedBox(
                height: 16.0,
              ),
              _itemImage(widget.item.imageUrl),
              const SizedBox(
                height: 16.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              _addToCartControl(widget.item)
            ],
          )
        ],
      ),
    );
  }

  Widget _mostLikeBadge(ColorScheme colorScheme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        color: colorScheme.onPrimary,
        child: const Text("#1 Most Liked"),
      ),
    );
  }

  Widget _itemImage(String imgUrl) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image:
              DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover)),
    );
  }

  Widget _addToCartControl(Item item) {
    return CartControl(addToCart: (number) {
      const uuid = Uuid();
      final uniqId = uuid.v1();
      final cartItem = CartItem(
        id: uniqId, 
        name: item.name,
        price: item.price,
        quantity: number
    
      );

      setState(() {
        widget.cartManager.addItem(cartItem);
        widget.quatityUpdated();
      });
      Navigator.pop(context);
    });
  }
}

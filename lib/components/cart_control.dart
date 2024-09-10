import 'package:flutter/material.dart';

class CartControl extends StatefulWidget {
  final void Function(int) addToCart;

  const CartControl({
    super.key,
    required this.addToCart,
  });

  @override
  State<CartControl> createState() => _CartControlState();
}

class _CartControlState extends State<CartControl> {
  int _cartNumber = 1;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMinusButton(),
        _buildCartNumberContainer(colorScheme),
        _buildPlusButton(),
        const Spacer(),
        _buildAddCartButton()
      ],
    );
  }

  Widget _buildMinusButton() {
    return IconButton(
      onPressed: () {
        setState(
          () {
            if (_cartNumber > 1) {
              _cartNumber -= 1;
            }
          },
        );
      },
      icon: const Icon(Icons.remove),
      tooltip: 'Decrease Cart Count',
    );
  }

  Widget _buildPlusButton() {
    return IconButton(
      onPressed: () {
        setState(
          () {
            _cartNumber += 1;
          },
        );
      },
      icon: const Icon(Icons.add),
      tooltip: 'Decrease Cart Count',
    );
  }

  Widget _buildCartNumberContainer(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: colorScheme.onPrimary,
      child: Text(_cartNumber.toString()),
    );
  }

  Widget _buildAddCartButton() {
    return FilledButton(
        onPressed: () {
          widget.addToCart(_cartNumber);
        },
        child: const Text('Add to Cart'));
  }
}

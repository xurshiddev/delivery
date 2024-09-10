import 'package:flutter/material.dart';
import 'package:yummy/models/food_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final FoodCategory category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    // TO DO: Replace with Card widget
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image(image: AssetImage(category.imgUrl)),
              ),
              Positioned(
                  left: 16,
                  top: 16,
                  child: Text(
                    "Yummy! 😋",
                    style: textTheme.headlineLarge,
                  )),
              Positioned(
                  right: 16,
                  bottom: 16,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      "Smothies",
                      style: textTheme.headlineLarge,
                    ),
                  ))
            ],
          ),
          ListTile(
            title: Text(
              category.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              "${category.numberOfRestaurant} places",
              style: textTheme.bodySmall,
            ),
            onTap: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now());
            },
          )
        ],
      ),
    );
  }
}

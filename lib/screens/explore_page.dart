import 'package:flutter/material.dart';
import 'package:yummy/api/mock_yummy_service.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/components/restaurant_section.dart';
import 'package:yummy/components/category_sections.dart';
import 'package:yummy/components/post_section.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';

class ExplorePage extends StatelessWidget {
  final moxsevice = MockYummyService();
  final CartManager cartManager;
  final OrderManager orderManager;
  ExplorePage(
      {super.key, required this.cartManager, required this.orderManager});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: moxsevice.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final restaurant = snapshot.data?.restaurants ?? [];
            final categories = snapshot.data?.categories ?? [];
            final posts = snapshot.data?.friendPosts ?? [];
            // TO DO: Replace this with Restaurant Section
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                RestaurantSection(
                  restaurants: restaurant,
                  cartManager: cartManager,
                  orderManager: orderManager,
                ),
                CategorySection(categories: categories),
                PostSection(posts: posts),
              ],
            );
          } else {
            return LottieBuilder.asset('assets/ai.json');
          }
        });
  }
}

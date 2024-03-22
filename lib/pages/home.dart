import 'package:flutter/material.dart';
import 'splash_screen.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SplashScreen(),
    );
  }
}

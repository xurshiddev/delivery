import 'package:flutter/material.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';
import 'constants.dart';
import 'home.dart';

void main() {
  runApp(Yummy());
}

class Yummy extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Yummy({super.key});
  @override  
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;
  final CartManager _cartManager = CartManager();
  final OrderManager _orderManager = OrderManager();

  ColorSelection colorSelected = ColorSelection.pink;
  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void changeThemeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = "Yummy";
    return MaterialApp(
        title: appTitle,

        //debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner
        themeMode: themeMode,
        theme: ThemeData(
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 240, 219, 240),
            )),
        darkTheme: ThemeData(
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 59, 53, 62))),
        home: Home(
          changeColor: changeThemeColor,
          changeTheme: changeThemeMode,
          selectedColor: colorSelected,
          cartManager: _cartManager,
          orderManager: _orderManager,
        ));
  }
}

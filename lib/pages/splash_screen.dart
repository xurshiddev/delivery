import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            scale: 1,
            alignment: Alignment(1, -1),
            image: AssetImage('assets/BG.png'),
            fit: BoxFit.cover,
          )),
      child: Stack(
        children: [
          const SizedBox(
            height: 1,
          ),
          const Positioned(
            top: 60,
            left: 10,
            child: Image(image: AssetImage('assets/LOGO.png')),
          ),
          Positioned(
              bottom: -18,
              child: Container(
                width: 410,
                height: 560,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 243, 243),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Column(children: [
                  const SizedBox(height: 50),
                  Container(
                      width: 104,
                      height: 104,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Image(image: AssetImage('assets/Box.png'))),
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    "Non-Contact\n Deliveries",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Numans",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    'When placing an order, select the option\n “Contactless delivery” and the courier will leave\n your order at the door.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: const Text(
                        "Oreder Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(onPressed: () => {}, child: const Text('DISMISS'))
                ]),
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // shadow color
                    spreadRadius: 5, // spread radius
                    blurRadius: 7, // blur radius
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),

            ),
            Image.asset('//'),
          ],
        ),
      ],
    ));
  }
}

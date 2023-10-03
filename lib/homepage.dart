import 'package:blog_explorer/tabscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BounceInDown(
            delay: const Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                'Blog Explorer',
                style: GoogleFonts.aBeeZee(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FadeIn(
              delay: const Duration(milliseconds: 400),
              child: Image.asset('assets/images/homepage.jpg')),
          SlideInLeft(
            delay: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.only(right: 70),
              child: Text(
                '"A new way to \n stay updated"',
                style: GoogleFonts.aBeeZee(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: BounceInUp(
              delay: const Duration(milliseconds: 600),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TabScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                label: const Text(
                  'View Blog',
                  style: TextStyle(
                      fontSize: 17.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 4, 28, 167),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

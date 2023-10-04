import 'package:blog_explorer/blogpage.dart';
import 'package:blog_explorer/favpage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 50.0,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.favorite, size: 30, color: Colors.white),
        ],
        color: const Color.fromARGB(255, 4, 28, 167),
        buttonBackgroundColor: const Color.fromARGB(255, 80, 94, 188),
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const BlogPage();
      case 1:
        return const FavoritePage();
      default:
        return Container();
    }
  }
}

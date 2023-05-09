import 'package:flutter/material.dart';

class CurrentWeatherNavBar extends StatefulWidget {
  const CurrentWeatherNavBar({super.key});

  @override
  State<CurrentWeatherNavBar> createState() => _CurrentWeatherNavBarState();
}

class _CurrentWeatherNavBarState extends State<CurrentWeatherNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            Icons.home,
            color: currentIndex == 0
                ? const Color.fromRGBO(201, 105, 144, 1)
                : Colors.grey,
            size: 40,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Search',
          icon: Icon(
            Icons.search,
            color: currentIndex == 1
                ? const Color.fromRGBO(201, 105, 144, 1)
                : Colors.grey,
            size: 40,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Bookmarks',
          icon: Icon(
            Icons.bookmark,
            color: currentIndex == 2
                ? const Color.fromRGBO(201, 105, 144, 1)
                : Colors.grey,
            size: 40,
          ),
        ),
        BottomNavigationBarItem(
          label: 'User',
          icon: Icon(
            Icons.people,
            color: currentIndex == 3
                ? const Color.fromRGBO(201, 105, 144, 1)
                : Colors.grey,
            size: 40,
          ),
        ),
      ],
      onTap: (int newIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      },
    );
  }
}
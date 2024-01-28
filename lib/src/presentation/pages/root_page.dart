import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavBarItems,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> get _buildBottomNavBarItems {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.face),
        label: profileTitle,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.sports_martial_arts),
        label: workoutTitle,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: trainingListTitle,
      ),
    ];
  }
}

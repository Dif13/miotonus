import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/presentation/pages/auth_page.dart';
import 'package:miotonus/src/utils/constants/strings.dart';
//TODO: import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String? name, imageUrl, userEmail, uid;

  bool needsWeb = Platform.isLinux | Platform.isWindows | kIsWeb;
  @override
  void initState() {
    super.initState();
    // Авто-логин при входе.

    if (needsWeb == false) {
      auth.authStateChanges().listen((event) {
        setState(() {
          //TODO: Fix it
          user = event;
        });
      });
    } else {
      //? Если web, или linux | win, то никогда не будет авторизованым изначально?
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: user != null ? widget.navigationShell : AuthPage(),
        bottomNavigationBar: user != null
            ? BottomNavigationBar(
                items: _buildBottomNavBarItems,
                currentIndex: widget.navigationShell.currentIndex,
                onTap: (index) => widget.navigationShell.goBranch(
                  index,
                  initialLocation: index == widget.navigationShell.currentIndex,
                ),
              )
            : null,
      ),
    );
  }

  Widget userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(user!.photoURL!),
              ),
            ),
          ),
          Text(user!.email!),
          Text(user!.displayName ?? ''),
          Text(user!.emailVerified.toString()),
          ElevatedButton(
            onPressed: auth.signOut,
            child: const Text('Выйти'),
          )
        ],
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

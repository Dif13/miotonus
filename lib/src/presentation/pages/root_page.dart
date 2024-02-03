import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miotonus/src/utils/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import 'package:sign_in_button/sign_in_button.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? name, imageUrl, userEmail, uid;
  User? _user;

  bool needsWeb = Platform.isLinux | Platform.isWindows | kIsWeb;

  @override
  void initState() {
    super.initState();
    // Авто-логин при входе.

    if (needsWeb == false) {
      _auth.authStateChanges().listen((event) {
        setState(() {
          //TODO: Fix it
          _user = event;
        });
      });
    } else {
      //? Если web, или linux | win, то никогда не будет авторизованым изначально?
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null ? widget.navigationShell : authPage(),
      bottomNavigationBar: _user != null
          ? BottomNavigationBar(
              items: _buildBottomNavBarItems,
              currentIndex: widget.navigationShell.currentIndex,
              onTap: (index) => widget.navigationShell.goBranch(
                index,
                initialLocation: index == widget.navigationShell.currentIndex,
              ),
            )
          : null,
    );
  }

  Future<User?> signInWithGoogle() async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    if (Platform.isLinux) {
      print('System is not supported yet!');
      return null;
    }
    if (needsWeb) {
      // Авторизация для WEB
      print('needsWeb: $needsWeb');
      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(googleAuthProvider);
        _user = userCredential.user;
      } catch (e) {
        print("Web Error: $e");
      }
    } else {
      //Авторизация для мобилки
      try {
        _auth.signInWithProvider(googleAuthProvider);
      } catch (e) {
        print("Mobile Error: $e");
      }
    }

    if (_user != null) {
      uid = _user!.uid;
      name = _user!.displayName;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      print('uid: $uid');
      print('name: $name');
    }
    return _user;
  }

  Widget authPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: _user != null ? userInfo() : googleSignInButton(),
    );
  }

  Widget userInfo() {
    return const SizedBox();
  }

  Widget googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Войти с помощью Google",
          onPressed: signInWithGoogle,
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

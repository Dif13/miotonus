import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool needsWeb = Platform.isLinux | Platform.isWindows | kIsWeb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: googleSignInButton(),
    );
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

  Future<User?> signInWithGoogle() async {
    if (needsWeb) {
      // Авторизация для WEB
      print('System is not supported yet!');
      return null;
    } else {
      //Авторизация для мобилки
      try {
        auth.signInWithProvider(googleAuthProvider);
      } catch (e) {
        print("Mobile Error: $e");
      }
    }
    return userCubit.state.user;
  }
}

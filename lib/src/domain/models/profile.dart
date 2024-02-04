import 'package:firebase_auth/firebase_auth.dart';

class Profile {
  int id;
  User? user;
  double maxHeight, minHeight;

  Profile({
    required this.id,
    required this.user,
    required this.maxHeight,
    required this.minHeight,
  });
}

import 'package:firebase_auth/firebase_auth.dart';

class Profile {
  int id;
  double maxHeight, minHeight;

  Profile({
    required this.id,
    required this.maxHeight,
    required this.minHeight,
  });
}

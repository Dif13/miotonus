import 'package:flutter/material.dart';
import 'package:miotonus/firebase_options.dart';
import 'package:miotonus/src/app.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

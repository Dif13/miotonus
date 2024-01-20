import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:miotonus/src/presentation/views/my_home_page.dart';
import 'package:miotonus/src/presentation/views/workout_page.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WorkoutPage(title: workoutTitle);
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'MyHomePage',
          builder: (BuildContext context, GoRouterState state) {
            return const MyHomePage(title: appTitle);
          },
        ),
      ],
    ),
  ],
);

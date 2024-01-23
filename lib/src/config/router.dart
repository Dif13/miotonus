import 'package:go_router/go_router.dart';
import 'package:miotonus/src/presentation/pages/rootPage/views/root_page.dart';
import 'package:miotonus/src/presentation/pages/workoutPage/views/my_home_page.dart';
import 'package:miotonus/src/presentation/pages/workoutPage/views/workout_page.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

final GoRouter router = GoRouter(
  initialLocation: '/workout',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/workout',
              builder: (context, state) =>
                  const WorkoutPage(title: workoutTitle),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/MyHomePage',
              builder: (context, state) => const MyHomePage(
                title: appTitle,
              ),
            )
          ],
        )
      ],
    ),
  ],
);

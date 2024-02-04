import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:miotonus/src/presentation/cubits/current_app_state.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';
import 'package:miotonus/src/presentation/cubits/workout_history_lst.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';
import 'package:miotonus/src/presentation/pages/detail_workout_page.dart';
import 'package:miotonus/src/presentation/pages/profile_page.dart';
import 'package:miotonus/src/presentation/pages/root_page.dart';
import 'package:miotonus/src/presentation/pages/training_list_page.dart';
import 'package:miotonus/src/presentation/pages/workout_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
User? user;

UserCubit userCubit = UserCubit();
WorkoutTableRowLstCubit workoutTableRowLstCubit = WorkoutTableRowLstCubit();
WorkoutHistoryLstCubit workoutHistoryLstCubit = WorkoutHistoryLstCubit();
CurrentAppStateCubit currentAppStateCubit =
    CurrentAppStateCubit(userCubit.state.id);

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
              path: '/profile',
              builder: (context, state) => ProfilePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/workout',
              builder: (context, state) => const WorkoutPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/workout_list',
              builder: (context, state) => const TrainingListPage(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => const DetailWorkoutPage(),
                )
              ],
            )
          ],
        )
      ],
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';
import 'package:miotonus/src/presentation/cubits/workout_history_lst.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';
import 'package:miotonus/src/presentation/pages/rootPage/views/root_page.dart';
import 'package:miotonus/src/presentation/pages/training_list_page/views/training_list_page.dart';
import 'package:miotonus/src/presentation/pages/workout_page/views/workout_page.dart';

UserCubit userCubit = UserCubit();
WorkoutTableRowLstCubit workoutTableRowLstCubit = WorkoutTableRowLstCubit();
WorkoutHistoryLstCubit workoutHistoryLstCubit = WorkoutHistoryLstCubit();

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
              builder: (context, state) => const WorkoutPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/workout_list',
              builder: (context, state) => const TrainingListPage(),
            )
          ],
        )
      ],
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:rentapp/data/remote_datasources/auth_remote_datasource.dart';
import 'package:rentapp/presentations/cubits/auth/auth_cubit.dart';
import 'package:rentapp/presentations/pages/auth_page.dart';
import 'package:rentapp/presentations/pages/car_detail_page.dart';
import 'package:rentapp/presentations/pages/car_list_page.dart';
import 'package:rentapp/presentations/pages/onboarding_page.dart';
import 'package:rentapp/routing/go_router_refresh_stream.dart';

class AppRoutes {
  static final authCubit = AuthCubit(AuthRemoteDatasource());

  static final onboardingName = 'onboarding';
  static final authName = 'auth';
  static final carListName = 'carList';
  static final carDetailName = 'carDetail';

  static final onboardingPath = '/';
  static final authPath = '/auth';
  static final carListPath = '/car-list';
  static final carDetailPath = '/car-detail/:id';

  static final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    initialLocation: onboardingPath,

    redirect: (context, state) {
      final authState = authCubit.state;

      final bool isLoggedIn = authState.status == AuthStatus.authenticated;

      final String location = state.matchedLocation;

      final bool isLoggingIn = location == authPath;
      final bool isOnboarding = location == onboardingPath;

      if (!isLoggedIn) {
        if (isOnboarding) return null;

        if (!isLoggingIn) return authPath;
      }

      if (isLoggedIn) {
        if (isLoggingIn || isOnboarding) return carListPath;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: onboardingPath,
        name: onboardingName,
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        path: authPath,
        name: authName,
        builder: (context, state) => AuthPage(),
      ),
      GoRoute(
        path: carListPath,
        name: carListName,
        builder: (context, state) => CarListPage(),
      ),
      GoRoute(
        name: carDetailName,
        path: carDetailPath,

        builder: (context, state) {
          final String carId = state.pathParameters['id']!;
          return CarDetailPage(carId: carId);
        },
      ),
    ],
  );
}

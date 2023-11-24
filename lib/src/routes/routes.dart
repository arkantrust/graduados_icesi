import 'package:go_router/go_router.dart';

import '/src/views/views.dart';

GoRouter get router => _router;

final GoRouter _router = GoRouter(
  initialLocation: HomeView.route,
  routes: <RouteBase>[
    GoRoute(
      path: HomeView.route,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: LoginView.route,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: ProfileView.route,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: BenefitsView.route,
      builder: (context, state) => const BenefitsView(),
    ),
    GoRoute(
      path: AgreementsView.route,
      builder: (context, state) => const AgreementsView(),
    ),
    GoRoute(
      path: AdminView.route,
      builder: (context, state) => const AdminView(),
    ),
    GoRoute(
      path: NotFoundView.route,
      builder: (context, state) => const NotFoundView(),
    ),
  ],
);

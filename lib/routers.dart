import 'package:go_router/go_router.dart';
import 'features/dashboard/presantation/screens/home_screen.dart';
import 'features/dashboard/presantation/screens/simple_screen.dart';


final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/activity-log',
      builder: (context, state) =>
      const SimpleScreen(title: "Activity Log"),
    ),
    GoRoute(
      path: '/heart-rate',
      builder: (context, state) =>
      const SimpleScreen(title: "Heart Rate"),
    ),
    GoRoute(
      path: '/spo2',
      builder: (context, state) =>
      const SimpleScreen(title: "SpO₂ Level"),
    ),
  ],
);

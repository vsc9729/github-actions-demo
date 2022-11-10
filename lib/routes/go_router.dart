import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_project/screens/home_screen.dart';
import 'package:navigation_project/screens/login_screen.dart';
import 'package:navigation_project/screens/profile_screen.dart';
import 'package:navigation_project/screens/signup_screen.dart';
import 'package:navigation_project/provider/login_info_provider.dart';
import 'package:navigation_project/services/auth_service.dart';
import 'package:provider/provider.dart';

var loginInfo = LoginInfoProvider();

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: ((context, state) {
        return const SignUpScreen();
      }),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: ((context, state) {
        return const LoginScreen();
      }),
    ),
    GoRoute(
      path: "/",
      name: 'home',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: <GoRoute>[
        GoRoute(
          path: 'profile',
          name: "profile",
          builder: ((context, state) {
            return const ProfileScreen();
          }),
        ),
      ],
    ),
  ],
  redirect: ((context, state) {
    bool isLoggedIn = AuthService(FirebaseAuth.instance).isLoggedIn();
    final bool loggingIn = state.location == '/login';
    final bool signingUp = state.location == '/signup';
    print(isLoggedIn);
    if (!isLoggedIn) {
      if (loggingIn) {
        return null;
      } else {
        if (signingUp) {
          return null;
        } else {
          return '/login';
        }
      }
    } else {
      return null;
    }
  }),
);

import 'package:aban_tether_challenge/features/auth/presentation/pages/login_page.dart';
import 'package:aban_tether_challenge/features/auth/presentation/pages/profile_page.dart';
import 'package:aban_tether_challenge/features/coin/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter getRouter(isLoggedIn) {
    return GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => isLoggedIn ? HomePage() : LoginPage(),
          routes: <RouteBase>[
            // GoRoute(
            //   path: 'mainPage',
            //   builder: (context, state) => MainPage(),
            //   routes: [

            //   ],
            // ),
            GoRoute(
              path: 'homePage',
              builder: (context, state) => HomePage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'profilePage',
                  builder: (context, state) => ProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

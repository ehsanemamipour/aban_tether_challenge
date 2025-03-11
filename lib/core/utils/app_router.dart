import 'package:aban_tether_challenge/features/auth/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter getRouter(isLoggedIn) {
    
    return GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          // builder: (context, state) => (isUserTappedFirstTime && !isUserLoggedIn) ? LoginPage() : MainPage(),
          builder: (context, state) => LoginPage(),
          routes: <RouteBase>[
            // GoRoute(
            //   path: 'mainPage',
            //   builder: (context, state) => MainPage(),
            //   routes: [

            //   ],
            // ),
          ],
        ),
      ],
    );
  }
}

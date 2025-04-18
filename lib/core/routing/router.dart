import 'package:go_router/go_router.dart';
import 'package:image_search_app/core/di/di_setup.dart';
import 'package:image_search_app/core/routing/routes.dart';
import 'package:image_search_app/presentation/search_image/image_detail_screen.dart';
import 'package:image_search_app/presentation/search_image/search_home_screen.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home, // '/search_home'
      builder: (context, state) => SearchHomeScreen(viewModel: getIt()),
      routes: [
        GoRoute(
          path: Routes.detail, //
          builder: (context, state) {
            final imageUrl = state.extra as String;
            return ImageDetailScreen(imageUrl: imageUrl);
          },
        ),
      ],
    ),
  ],
);

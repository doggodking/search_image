import 'package:go_router/go_router.dart';
import 'package:image_search_app/core/di/di_setup.dart';
import 'package:image_search_app/core/routing/routes.dart';
import 'package:image_search_app/presentation/search_image/image_detail_screen.dart';
import 'package:image_search_app/presentation/search_image/search_home_screen.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
        context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return navigationShell;
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home, //
              builder:
                  (context, state) => SearchHomeScreen(
                    viewModel: getIt(),
                    onTabImage: (image) {
                      context.push(
                        Routes.detailPath(),
                        extra: image.largeImageURL,
                      );
                    },
                  ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.detailPath(), //
      builder: (context, state) {
        final imageUrl = state.extra as String;
        return ImageDetailScreen(imageUrl: imageUrl);
      },
    ),
  ],
);

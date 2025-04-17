import 'package:go_router/go_router.dart';
import 'package:image_search_app/core/di/app_dependencies.dart';
import 'package:image_search_app/core/routing/routes.dart';
import 'package:image_search_app/presentation/search_image/image_detail_screen.dart';
import 'package:image_search_app/presentation/search_image/search_home_screen.dart';

GoRouter appRouter() {
  final deps = AppDependencies();

  return GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.home, // '/search_home'
        builder:
            (context, state) => SearchHomeScreen(viewModel: deps.viewModel),
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
}

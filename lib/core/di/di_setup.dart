// late final ImageDataSource dataSource;
// late final ImageRepository repository;
// late final SearchImageUseCase searchImageUseCase;
// late final SearchImageViewModel viewModel;

import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/data_source/image_data_source.dart';
import 'package:image_search_app/data/data_source/image_remote_data_source_impl.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/retository/image_repository.dart';
import 'package:image_search_app/domain/user_case/search_image_use_case.dart';
import 'package:image_search_app/presentation/search_image/search_image_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Register your dependencies here
  getIt.registerSingleton<ImageDataSource>(ImageRemoteDataSourceImpl());
  getIt.registerSingleton<ImageRepository>(
    ImageRepositoryImpl(dataSource: getIt()),
  );
  getIt.registerSingleton<SearchImageUseCase>(SearchImageUseCase(getIt()));
  getIt.registerFactory<SearchImageViewModel>(
    () => SearchImageViewModel(getIt()),
  );
}

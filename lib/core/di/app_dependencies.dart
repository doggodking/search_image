import 'package:image_search_app/data/data_source/image_data_source.dart';
import 'package:image_search_app/data/data_source/image_remote_data_source_impl.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/domain/retository/image_repository.dart';
import 'package:image_search_app/domain/user_case/search_image_use_case.dart';
import 'package:image_search_app/presentation/search_image/search_image_view_model.dart';

class AppDependencies {
  static final AppDependencies _instance = AppDependencies._internal();

  factory AppDependencies() => _instance;

  AppDependencies._internal() {
    _init();
  }

  late final ImageDataSource dataSource;
  late final ImageRepository repository;
  late final SearchImageUseCase searchImageUseCase;
  late final SearchImageViewModel viewModel;

  void _init() {
    dataSource = ImageRemoteDataSourceImpl();
    repository = ImageRepositoryImpl(dataSource: dataSource);
    searchImageUseCase = SearchImageUseCase(repository);
    viewModel = SearchImageViewModel(searchImageUseCase);
  }
}

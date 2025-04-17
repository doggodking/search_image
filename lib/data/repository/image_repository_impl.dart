import 'package:image_search_app/core/error/failure.dart';
import 'package:image_search_app/core/error/result.dart';
import 'package:image_search_app/data/data_source/image_data_source.dart';
import 'package:image_search_app/domain/model/image_model.dart';
import 'package:image_search_app/domain/retository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDataSource _dataSource;

  ImageRepositoryImpl({required ImageDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Result<List<ImageModel>>> searchImages(String query) async {
    try {
      final images = await _dataSource.fetchImagesSearch(query);
      await _dataSource.fetchImagesSearch(query);
      return Result.success(images);
    } catch (e) {
      return Result.error(Failure('이미지 데이터를 불러 오는데 실패함.', cause: e));
    }
  }
}

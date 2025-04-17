import 'package:image_search_app/core/error/result.dart';
import 'package:image_search_app/domain/model/image_model.dart';

abstract interface class ImageRepository {
  Future<Result<List<ImageModel>>> searchImages(String query);
}

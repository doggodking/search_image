import 'package:image_search_app/domain/model/image_model.dart';

abstract interface class ImageDataSource {
  Future<List<ImageModel>> fetchImagesSearch(String query);
}

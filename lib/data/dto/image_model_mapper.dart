import 'package:image_search_app/domain/model/image_model.dart';

import 'image_dto.dart';

extension ImageModelMapper on ImageDto {
  ImageModel toImageModel() {
    return ImageModel(
      id: (id as int?) ?? 0,
      largeImageURL: largeImageURL ?? '',
      previewURL: previewURL ?? '',
    );
  }
}

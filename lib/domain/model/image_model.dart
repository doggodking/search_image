import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_model.freezed.dart';

@freezed
class ImageModel with _$ImageModel {
  final int id;
  final String largeImageURL;
  final String previewURL;
  ImageModel({
    required this.id,
    required this.largeImageURL,
    required this.previewURL,
  });
}

import 'package:json_annotation/json_annotation.dart';

import 'image_dto.dart';

part 'pixabay_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PixabayResponseDto {
  final num? total;
  final num? totalHits;
  final List<ImageDto>? hits;

  PixabayResponseDto({this.total, this.totalHits, this.hits});

  factory PixabayResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PixabayResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PixabayResponseDtoToJson(this);
}

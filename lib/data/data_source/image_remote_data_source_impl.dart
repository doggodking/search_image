import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_search_app/data/data_source/image_data_source.dart';
import 'package:image_search_app/data/dto/image_model_mapper.dart';
import 'package:image_search_app/data/dto/pixabay_response_dto.dart';
import 'package:image_search_app/domain/model/image_model.dart';

abstract class ImageRemoteDataSource implements ImageDataSource {
  @override
  Future<List<ImageModel>> fetchImagesSearch(String query);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  static const _basePath = 'https://pixabay.com/api/';
  static const _apiKey = '10711147-dc41758b93b263957026bdadb';

  final http.Client _client;

  ImageRemoteDataSourceImpl({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<List<ImageModel>> fetchImagesSearch(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('$_basePath?key=$_apiKey&q=$query&image_type=photo'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final dto = PixabayResponseDto.fromJson(json);
        final images = dto.hits ?? [];
        return images.map((e) => e.toImageModel()).toList();
      } else {
        debugPrint('Pixabay API 요청 실패: ${response.statusCode}');

        throw Exception('Pixabay API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Pixabay API 요청 실패: ${e}');
      throw Exception('이미지를 불러오는 데 실패했습니다. 인터넷 연결을 확인해주세요.');
    }
  }
}

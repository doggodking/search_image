import 'package:image_search_app/core/error/result.dart';
import 'package:image_search_app/core/error/ui_state.dart';
import 'package:image_search_app/domain/model/image_model.dart';
import 'package:image_search_app/domain/retository/image_repository.dart';

class SearchImageUseCase {
  final ImageRepository _repository;

  SearchImageUseCase(this._repository);

  Future<UiState<List<ImageModel>>> call(String query) async {
    final result = await _repository.searchImages(query);
    switch (result) {
      case Success(:final data):
        return data.isEmpty ? const UiState.empty() : UiState.success(data);
      case Error(:final failure):
        return UiState.error(failure.message);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:image_search_app/core/error/ui_state.dart';
import 'package:image_search_app/domain/user_case/search_image_use_case.dart';
import 'package:image_search_app/presentation/search_image/search_image_state.dart';

class SearchImageViewModel with ChangeNotifier {
  final SearchImageUseCase _searchImageUseCase;

  SearchImageState _state = const SearchImageState();
  SearchImageState get state => _state;

  SearchImageViewModel(this._searchImageUseCase);

  Future<void> load() async {
    if (_state.query.trim().isEmpty) return;

    _state = _state.copyWith(state: const UiState.loading());
    notifyListeners();

    final result = await _searchImageUseCase(_state.query);
    _state = _state.copyWith(state: result);
    notifyListeners();
  }

  void updateQuery(String query) {
    _state = _state.copyWith(query: query);
    notifyListeners();
  }
}

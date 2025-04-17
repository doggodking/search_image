import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_search_app/core/error/ui_state.dart';
import 'package:image_search_app/domain/model/image_model.dart';

part 'search_image_state.freezed.dart';

@freezed
class SearchImageState with _$SearchImageState {
  final UiState<List<ImageModel>> state;
  final String query;

  const SearchImageState({this.state = const UiState.empty(), this.query = ''});
}

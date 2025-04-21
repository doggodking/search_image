import 'package:flutter/material.dart';
import 'package:image_search_app/core/error/ui_state.dart';
import 'package:image_search_app/domain/model/image_model.dart';
import 'package:image_search_app/presentation/component/app_image.dart';
import 'package:image_search_app/presentation/component/input_field.dart';
import 'package:image_search_app/presentation/component/skelton_animtion_widget.dart';
import 'package:image_search_app/presentation/search_image/search_image_view_model.dart';

class SearchHomeScreen extends StatefulWidget {
  final SearchImageViewModel viewModel;
  final Function(ImageModel image) onTabImage;

  const SearchHomeScreen({
    super.key,
    required this.viewModel,
    required this.onTabImage,
  });

  @override
  State<SearchHomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends State<SearchHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final state = widget.viewModel.state;

        return Scaffold(
          appBar: AppBar(title: const Text('이미지 검색앱'), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SearchTextField(
                  placeholderText: 'Search',
                  value: state.query,
                  onValueChange: widget.viewModel.updateQuery,
                  onSubmitted: (_) => widget.viewModel.load(),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: switch (state.state) {
                    UiLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),

                    UiEmpty() => const Center(child: Text('검색 결과가 없습니다.')),

                    UiError(message: final msg) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('에러 발생: $msg'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: widget.viewModel.load,
                            child: const Text('다시 검색'),
                          ),
                        ],
                      ),
                    ),

                    UiSuccess(data: final images) => GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        final image = images[index];

                        return GestureDetector(
                          onTap: () => widget.onTabImage(image),
                          child: AppImage(
                            path: image.previewURL,
                            borderRadius: BorderRadius.circular(15),
                            skeletonBuilder:
                                (context, size) =>
                                    SkeletonAnimationWidget(size: size),
                          ),
                        );
                      },
                    ),
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/component/app_image.dart';

class SearchTextField extends StatefulWidget {
  final String placeholderText;
  final String value;
  final void Function(String)? onValueChange;
  final void Function(String)? onSubmitted;

  const SearchTextField({
    super.key,
    required this.placeholderText,
    required this.value,
    this.onValueChange,
    this.onSubmitted,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();

  static Widget searchIcon() {
    return const AppImage(path: 'assets/images/icons/search_normal.png');
  }
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant SearchTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: _controller,
        onChanged: widget.onValueChange,
        onSubmitted: widget.onSubmitted,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: widget.placeholderText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF4FB6B2), width: 2),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF4FB6B2), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF4FB6B2), width: 2),
          ),

          suffixIcon: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            icon: const Icon(Icons.search, color: Color(0xFF4FB6B2), size: 18),
            onPressed: () {
              widget.onSubmitted?.call(_controller.text);
            },
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 20,
            minWidth: 40,
          ),
        ),
      ),
    );
  }
}

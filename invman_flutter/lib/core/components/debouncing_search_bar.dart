import 'dart:async';
import 'package:flutter/material.dart';

class DebouncingSearchBar extends StatefulWidget {
  final bool autoFocus;
  final String? hintText;
  final String? text;
  final int debounceMs;
  final TextEditingController? controller;
  final Function(String) onChanged;
  final VoidCallback? onClear;

  const DebouncingSearchBar({
    super.key,
    required this.onChanged,
    this.autoFocus = false,
    this.hintText,
    this.debounceMs = 250,
    this.text,
    this.controller,
    this.onClear,
  });

  @override
  State<DebouncingSearchBar> createState() => _DebouncingSearchBarState();
}

class _DebouncingSearchBarState extends State<DebouncingSearchBar> {
  Timer? _debounce;
  late final TextEditingController _controller;
  final ValueNotifier<bool> _hasText = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.text);
    _hasText.value = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _hasText.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    _hasText.value = _controller.text.isNotEmpty;
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      autoFocus: widget.autoFocus,
      hintText: widget.hintText,
      trailing: [
        ValueListenableBuilder<bool>(
          valueListenable: _hasText,
          builder: (context, hasText, _) {
            if (!hasText) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearText,
            );
          },
        ),
      ],
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(Duration(milliseconds: widget.debounceMs), () {
          widget.onChanged(value);
        });
      },
    );
  }
}

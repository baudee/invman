import 'dart:async';
import 'package:flutter/material.dart';

class DebouncingSearchBar extends StatefulWidget {
  final bool autoFocus;
  final String? hintText;
  final int debounceMs;
  final Function(String) onChanged;

  const DebouncingSearchBar({
    super.key,
    required this.onChanged,
    this.autoFocus = false,
    this.hintText,
    this.debounceMs = 250,
  });

  @override
  State<DebouncingSearchBar> createState() => _DebouncingSearchBarState();
}

class _DebouncingSearchBarState extends State<DebouncingSearchBar> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      autoFocus: widget.autoFocus,
      hintText: widget.hintText,
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(Duration(milliseconds: widget.debounceMs), () {
          widget.onChanged(value);
        });
      },
    );
  }
}

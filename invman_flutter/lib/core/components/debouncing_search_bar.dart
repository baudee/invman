import 'dart:async';
import 'package:flutter/material.dart';

class DebouncingSearchBar extends StatefulWidget {
  final bool autoFocus;
  final String? hintText;
  final String? text;
  final int debounceMs;
  final TextEditingController? controller;
  final Function(String) onChanged;

  const DebouncingSearchBar({
    super.key,
    required this.onChanged,
    this.autoFocus = false,
    this.hintText,
    this.debounceMs = 250,
    this.text,
    this.controller,
  });

  @override
  State<DebouncingSearchBar> createState() => _DebouncingSearchBarState();
}

class _DebouncingSearchBarState extends State<DebouncingSearchBar> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: widget.controller,
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

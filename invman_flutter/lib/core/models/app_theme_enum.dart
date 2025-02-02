import 'package:flutter/material.dart';

enum AppThemeEnum {
  light('light', 'Light', ThemeMode.light),
  dark('dark', 'Dark', ThemeMode.dark),
  system('system', 'System', ThemeMode.system),
  ;

  final String value;
  final String label;
  final ThemeMode mode;
  const AppThemeEnum(this.value, this.label, this.mode);
}

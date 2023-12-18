import 'package:flutter/material.dart';

abstract class HighlightStrategy {
  bool match(String word);
  TextSpan textSpan(String word, TextStyle? textStyle);
}

class KeyHighlightStrategy extends HighlightStrategy {
  @override
  bool match(String word) => RegExp(r'\".*?\"\s*:').hasMatch(word);

  @override
  TextSpan textSpan(String word, TextStyle? textStyle) =>
      TextSpan(text: word, style: textStyle?.copyWith(color: Colors.blue));
}

class StringHighlightStrategy extends HighlightStrategy {
  @override
  bool match(String word) => RegExp(r'\".*?\"').hasMatch(word);

  @override
  TextSpan textSpan(String word, TextStyle? textStyle) =>
      TextSpan(text: word, style: textStyle?.copyWith(color: Colors.green));
}

class NumberHighlightStrategy extends HighlightStrategy {
  @override
  bool match(String word) => RegExp(r'\s*\b(\d+(\.\d+)?)\b').hasMatch(word);

  @override
  TextSpan textSpan(String word, TextStyle? textStyle) =>
      TextSpan(text: word, style: textStyle?.copyWith(color: Colors.orange));
}

class BoolHighlightStrategy extends HighlightStrategy {
  @override
  bool match(String word) => RegExp(r'\b(true|false)\b').hasMatch(word);

  @override
  TextSpan textSpan(String word, TextStyle? textStyle) =>
      TextSpan(text: word, style: textStyle?.copyWith(color: Colors.purple));
}

class NullHighlightStrategy extends HighlightStrategy {
  @override
  bool match(String word) => RegExp(r'\bnull\b').hasMatch(word);

  @override
  TextSpan textSpan(String word, TextStyle? textStyle) =>
      TextSpan(text: word, style: textStyle?.copyWith(color: Colors.purple));
}

class SpecialCharHighlightStrategy extends HighlightStrategy {
  @override
  bool match(String word) => RegExp(r'[{}\[\],:]').hasMatch(word);

  @override
  TextSpan textSpan(String word, TextStyle? textStyle) =>
      TextSpan(text: word, style: textStyle?.copyWith(color: Colors.red));
}

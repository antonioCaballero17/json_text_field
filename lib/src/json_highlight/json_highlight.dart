import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:json_text_field_editor/src/json_highlight/highlight_strategy.dart';

class JsonHighlight extends SpecialTextSpanBuilder {
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    List<HighlightStrategy> strategies = [
      KeyHighlightStrategy(),
      StringHighlightStrategy(),
      NumberHighlightStrategy(),
      BoolHighlightStrategy(),
      NullHighlightStrategy(),
      SpecialCharHighlightStrategy(),
    ];

    List<TextSpan> spans = [];

    data.splitMapJoin(
      RegExp(
          r'\".*?\"\s*:|\".*?\"|\s*\b(\d+(\.\d+)?)\b|\b(true|false|null)\b|[{}\[\],]'),
      onMatch: (m) {
        String word = m.group(0)!;
        spans.add(strategies
            .firstWhere((element) => element.match(word))
            .textSpan(word, textStyle));
        return '';
      },
      onNonMatch: (n) {
        spans.add(TextSpan(text: n, style: textStyle));
        return '';
      },
    );

    return TextSpan(children: spans);
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      required int index}) {
    throw UnimplementedError();
  }
}

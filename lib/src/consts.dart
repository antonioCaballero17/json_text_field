import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final kIsApple = !kIsWeb && (Platform.isIOS || Platform.isMacOS);
final kFontFamilyFallback = kIsApple ? null : null;
final kCodeStyle = TextStyle(
  fontFamilyFallback: kFontFamilyFallback,
);
//
const kHintOpacity = 0.6;
const kForegroundOpacity = 0.05;
const kBorderRadius8 = BorderRadius.all(Radius.circular(8));
const kColorTransparent = Colors.transparent;

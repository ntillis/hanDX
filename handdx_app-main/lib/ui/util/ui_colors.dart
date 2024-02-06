import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UiColors {
  static const accent = Color(0xFF0033D2);
  static const accentAlt = Color(0xFF0064E4);
  static const secondary = Color(0xFF6575FC);
  static const background = Color(0xFFFDFDFE);
  static const backgroundLight = Color(0xFFF6F9FA);
  static const backgroundDark = Color(0xFF0C122C);
  static const backgroundDark2 = Color(0xFF0D0808);
  static const textDark = Color(0xFF101D21);
  static const textLight = Color(0xFFFAFAFA);

  static get barBackgroundColor => usePlatformBrightness() == Brightness.light
      ? CupertinoColors.secondarySystemBackground
      : CupertinoColors.darkBackgroundGray;

  static get textColor =>
      usePlatformBrightness() == Brightness.light ? textDark : textLight;

  static get backgroundColor => usePlatformBrightness() == Brightness.light
      ? backgroundLight
      : backgroundDark2;
}

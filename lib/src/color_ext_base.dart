import 'dart:ui' show Color;
import 'dart:math';

import 'package:flutter/foundation.dart';

/// Convenience alias for our British friends whom we hate.
typedef Colour = Color;

extension ColourExt on Colour {
  /// Constructs a CMYK color
  static Colour fromCMYK(double c, double m, double y, double k) {
    final c0 = clampDouble(c, 0.0, 1.0);
    final m0 = clampDouble(m, 0.0, 1.0);
    final y0 = clampDouble(y, 0.0, 1.0);
    final k0 = clampDouble(k, 0.0, 1.0);

    final r0 = (1 - c0) * (1 - k0);
    final g0 = (1 - m0) * (1 - k0);
    final b0 = (1 - y0) * (1 - k0);

    return Colour.fromRGBO(r0.round(), g0.round(), b0.round(), 1);
  }

  /// Converts a [double] in [0.0, 1.0] to an int channel in [0, 255].
  ///  - n is the channel value
  int _scaleAndMask(double n) => (n * 255.0).round() & 0xff;

  /// Returns the inverted colour.
  Colour get inverted => Colour.fromARGB(
    _scaleAndMask(a),
    255 - _scaleAndMask(r),
    255 - _scaleAndMask(g),
    255 - _scaleAndMask(b),
  );

  /// The red channel of this colour in [0, 255].
  int getRed() => _scaleAndMask(r);

  /// The green channel of this colour in [0, 255].
  int getGreen() => _scaleAndMask(g);

  /// The blue channel of this colour in [0, 255].
  int getBlue() => _scaleAndMask(b);

  /// The alpha channel of this colour in [0, 255].
  int getAlpha() => _scaleAndMask(a);

  /// The black channel of the colour.
  double get k => 1 - [r, g, b].reduce(max);

  /// The cyan channel of the colour.
  double get c => k != 0 ? (g + b) / 2 : 0;

  /// The magenta channel of the colour.
  double get m => k != 0 ? (r + b) / 2 : 0;

  /// The yellow channel of the colour.
  double get y => k != 0 ? (r + g) / 2 : 0;

  /// Returns this colour scaled by a [luminance] factor in [0.0, 1.0].
  Colour withLuminance(double luminance) {
    if (luminance < 0.0 || luminance > 1.0) {
      throw RangeError.range(luminance, 0, 1);
    }
    return Colour.fromARGB(
      _scaleAndMask(a),
      _scaleAndMask(r * luminance),
      _scaleAndMask(g * luminance),
      _scaleAndMask(b * luminance),
    );
  }
}

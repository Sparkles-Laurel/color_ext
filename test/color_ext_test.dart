import 'package:color_ext/color_ext.dart';
import 'package:test/test.dart';

void main() {
  group('ColourExt', () {
    test('fromCMYK produces correct RGB values', () {
      final black = ColourExt.fromCMYK(0, 0, 0, 1);
      expect(black.r, 0);
      expect(black.g, 0);
      expect(black.b, 0);

      final white = ColourExt.fromCMYK(0, 0, 0, 0);
      expect(white.r, 1);
      expect(white.g, 1);
      expect(white.b, 1);

      final cyan = ColourExt.fromCMYK(1, 0, 0, 0);
      expect(cyan.r, 0);
      expect(cyan.g, 1);
      expect(cyan.b, 1);
    });

    test('inverted returns correct values', () {
      final color = Colour.fromRGBO(100, 150, 200, 1);
      final inverted = color.inverted;

      expect(inverted.r, 0.607843137254902); // 255 - 100
      expect(inverted.g, 0.4117647058823529); // 255 - 150
      expect(inverted.b, 0.2156862745098039); // 255 - 200
      expect(inverted.a, 1); // unchanged
    });

    test('channel getters return expected values', () {
      final color = Colour.fromRGBO(12, 34, 56, 0.5);
      expect(color.r, 0.04705882352941176);
      expect(color.g, 0.1333333333333333);
      expect(color.b, 0.2196078431372549);
      expect(color.a, 0.5); // 0.5 * 255 ≈ 128
    });

    test('withLuminance scales channels correctly', () {
      final color = Colour.fromRGBO(100, 150, 200, 1);
      final darker = color.withLuminance(0.5);

      expect(darker.r, 0.1960784313725490);
      expect(darker.g, 0.2941176470588235);
      expect(darker.b, 0.3921568627450980);
      expect(darker.a, 1); // alpha unchanged
    });

    test('withLuminance throws RangeError for invalid values', () {
      final color = Colour.fromRGBO(100, 150, 200, 1);
      expect(() => color.withLuminance(-0.1), throwsRangeError);
      expect(() => color.withLuminance(1.1), throwsRangeError);
    });

    test('CMYK getters return expected values', () {
      final color = Colour.fromRGBO(0, 128, 255, 1); // RGB
      final k = color.k;
      final c = color.c;
      final m = color.m;
      final y = color.y;

      // Ensure they are in the 0-1 range
      expect(k, inInclusiveRange(0, 1));
      expect(c, inInclusiveRange(0, 1));
      expect(m, inInclusiveRange(0, 1));
      expect(y, inInclusiveRange(0, 1));
    });

    test('CMYK getters return expected values', () {
      // Helper function to compute expected CMYK
      double cmykC(int r, int g, int b) => 1 - r / 255;
      double cmykM(int r, int g, int b) => 1 - g / 255;
      double cmykY(int r, int g, int b) => 1 - b / 255;
      double cmykK(int r, int g, int b) => [
        1 - r / 255,
        1 - g / 255,
        1 - b / 255,
      ].reduce((a, b) => a > b ? a : b);

      final color = Colour.fromRGBO(64, 128, 192, 1);

      final expectedK = cmykK(64, 128, 192);
      final expectedC = expectedK == 1
          ? 0
          : (cmykC(64, 128, 192) - expectedK) / (1 - expectedK);
      final expectedM = expectedK == 1
          ? 0
          : (cmykM(64, 128, 192) - expectedK) / (1 - expectedK);
      final expectedY = expectedK == 1
          ? 0
          : (cmykY(64, 128, 192) - expectedK) / (1 - expectedK);

      expect(color.k, closeTo(expectedK, 0.01));
      expect(color.c, closeTo(expectedC, 0.01));
      expect(color.m, closeTo(expectedM, 0.01));
      expect(color.y, closeTo(expectedY, 0.01));
    });
  });
}

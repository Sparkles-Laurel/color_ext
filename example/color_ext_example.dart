import 'package:color_ext/color_ext.dart';

void main() {
  // Create a colour using ARGB
  final colour = Colour.fromARGB(0xFF, 0xCC, 0xFF, 0xCC); // #CCFFCC

  // Invert the colour
  final inverted = colour.inverted;
  print(
    "Invert(#CCFFCC): "
    "R: ${inverted.getRed()}, "
    "G: ${inverted.getGreen()}, "
    "B: ${inverted.getBlue()}, "
    "A: ${inverted.getAlpha()}",
  );

  // Scale luminance by 50%
  final halfShade = colour.withLuminance(0.5);
  print(
    "Half-luminance(#CCFFCC): "
    "R: ${halfShade.getRed()}, "
    "G: ${halfShade.getGreen()}, "
    "B: ${halfShade.getBlue()}, "
    "A: ${halfShade.getAlpha()}",
  );

  // Access CMYK channels
  print(
    "CMYK of #CCFFCC: "
    "C: ${colour.c.toStringAsFixed(2)}, "
    "M: ${colour.m.toStringAsFixed(2)}, "
    "Y: ${colour.y.toStringAsFixed(2)}, "
    "K: ${colour.k.toStringAsFixed(2)}",
  );
}

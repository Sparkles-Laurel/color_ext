<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# color_ext

A small but powerful Dart/Flutter package providing extensions and utilities for working with colors. Includes convenient RGBA/CMYK conversion, color inversion, luminance scaling, and easy access to individual channels. Perfect for designers, Flutter developers, or anyone who wants more control over colors programmatically.

## Features

- Create colors from **CMYK** values.  
- Invert colors easily using `.inverted`.  
- Scale colors by luminance using `.withLuminance(double)`.  
- Access RGBA channels as integers (`0-255`).  
- Access CMYK channels as doubles (`0.0-1.0`).  
- Fully Dart-native, works in both Flutter and server-side Dart.

## Getting started

### Prerequisites

- Dart SDK >= 2.18  
- Flutter >= 3.0 (optional, if using in Flutter apps)  

### Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  color_ext: ^0.1.0
```

Then run:

```bash
dart pub get
```

or for Flutter projects
```bash
flutter pub get
```

## Usage
### Basic example
```dart
import 'package:color_ext/color_ext.dart';

void main() {
  // Create a color from ARGB
  final colour = Colour.fromARGB(0xFF, 0xCC, 0xFF, 0xCC);

  // Invert the color
  final inverted = colour.inverted;
  print("Inverted color: R:${inverted.red}, G:${inverted.green}, B:${inverted.blue}");

  // Scale luminance
  final halfShade = colour.withLuminance(0.5);
  print("Half-luminance color: R:${halfShade.red}, G:${halfShade.green}, B:${halfShade.blue}");

  // Create from CMYK
  final cyan = ColourExt.fromCMYK(1.0, 0.0, 0.0, 0.0);
  print("Cyan RGB: ${cyan.red}, ${cyan.green}, ${cyan.blue}");

  // Access CMYK channels
  print("CMYK of #CCFFCC: "
      "C: ${colour.c.toStringAsFixed(2)}, "
      "M: ${colour.m.toStringAsFixed(2)}, "
      "Y: ${colour.y.toStringAsFixed(2)}, "
      "K: ${colour.k.toStringAsFixed(2)}");
}
```
### Output (approximate)
```
Inverted color: R:51, G:0, B:51
Half-luminance color: R:102, G:127, B:102
Cyan RGB: 0, 255, 255
CMYK of #CCFFCC: C:0.50, M:0.25, Y:0.50, K:0.00
```
### Additional information
- Documentation: see [[INSERT PUB DOCS HERE LATER]](#) for more examples
- Contributing: see [CONTRIBUTING.md](tree/master/CONTRIBUTING.md)
- LICENSE: This Project is licensed under Apache License 2.0, see [LICENSE](tree/master/LICENSE) for more information
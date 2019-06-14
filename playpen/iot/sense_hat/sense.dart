import 'dart:io';

final boxPixels = [
  for (int x = 0; x <= 7; x++) Pixel(x, 0, 0xFFFFFF),
  for (int x = 0; x <= 7; x++) Pixel(x, 7, 0xFFFFFF),
  for (int y = 0; y <= 7; y++) Pixel(0, y, 0xFFFFFF),
  for (int y = 0; y <= 7; y++) Pixel(7, y, 0xFFFFFF),
];

final flutterLightBlue = 0x0000FF;
final flutterMediumBlue = 0x3333FF;
final flutterDarkBlue = 0x6666FF;

final flutterLogo = [
  Pixel(0, 3, flutterLightBlue),
  Pixel(0, 4, flutterLightBlue),
  Pixel(1, 2, flutterLightBlue),
  Pixel(1, 3, flutterLightBlue),
  Pixel(2, 1, flutterLightBlue),
  Pixel(2, 2, flutterLightBlue),
  Pixel(3, 0, flutterLightBlue),
  Pixel(3, 1, flutterLightBlue),
  Pixel(3, 3, flutterLightBlue),
  Pixel(3, 4, flutterLightBlue),
  Pixel(4, 0, flutterLightBlue),
  Pixel(4, 1, flutterLightBlue),
  Pixel(4, 3, flutterLightBlue),
  Pixel(4, 4, flutterLightBlue),
  Pixel(5, 1, flutterMediumBlue),
  Pixel(5, 2, flutterMediumBlue),
  Pixel(5, 3, flutterMediumBlue),
  Pixel(6, 2, flutterDarkBlue),
  Pixel(6, 3, flutterDarkBlue),
  Pixel(7, 3, flutterDarkBlue),
  Pixel(7, 4, flutterDarkBlue),
];

main() {
  // Zero out the test device file
  //File('test.bin').writeAsBytes(List.generate(64 * 2, (i) => 0));
  final buffer = FrameBuffer('test.bin');
  buffer.resetPixels();
  buffer.setPixels(flutterLogo);
  // buffer.setPixel(1, 7, 255, 255, 255);
}

class FrameBuffer {
  String device;

  FrameBuffer([String fbDevice]) {
    device = fbDevice ?? _frameBufferDevice;
  }

  void setPixels(List<Pixel> pixels) async {
    final file = File(device);
    final writer = await file.open(mode: FileMode.append);
    pixels.forEach((p) => _setPixel(p, writer));
    writer.closeSync();
  }

  void resetPixels() async {
    await setPixels(List.generate(64, (i) => Pixel(i % 8, (i ~/ 8), 0x000000)));
  }

  void _setPixel(Pixel pixel, RandomAccessFile deviceFile) {
    final bytes = _createColourBytes(pixel.rgb);
    deviceFile.setPositionSync(((pixel.x * 8) + pixel.y) * 2);
    deviceFile.writeFromSync([upperByte(bytes), lowerByte(bytes)]);
  }

  int _createColourBytes(int rgb) {
    final r = rgb & 0x00FF;
    final g = (rgb & 0xFF00) >> 8;
    final b = (rgb & 0xFF0000) >> 16;
    return _createPixelBytes(r, g, b);
  }

  void setPixel(int x, int y, int r, int g, int b) async {
    assert(x >= 0 && x <= 7);
    assert(y >= 0 && y <= 7);
    assert(r >= 0 && r <= 255);
    assert(g >= 0 && g <= 255);
    assert(b >= 0 && b <= 255);

    final file = File(device);
    final writer = await file.open(mode: FileMode.append);
    final bytes = _createPixelBytes(r, g, b);
    writer.setPositionSync(((y * 8) + x) * 2);
    writer.writeFromSync([upperByte(bytes), lowerByte(bytes)]);
    writer.closeSync();
  }

  /// Encodes individual RGB values into a 16 bit RGB565
  int _createPixelBytes(int r, int g, int b) {
    r = (r >> 3) & 0x1F;
    g = (g >> 2) & 0x3F;
    b = (b >> 3) & 0x1F;
    return (r << 11) + (g << 5) + b;
  }

  /// Returns the value of the lower byte from a 16 bit word
  int lowerByte(final int word) => word & 0x00FF;

  /// Returns the value of the upper byte from a 16 bit word
  int upperByte(final int word) => (word & 0xFF00) >> 8;

  String _frameBufferDevice() {
    return 'device file path to be returned here';
  }
}

class Pixel {
  const Pixel(this.x, this.y, this.rgb)
      : assert(x >= 0 && x <= 7 && y >= 0 && y <= 7);
  final int x;
  final int y;
  final int rgb;
}

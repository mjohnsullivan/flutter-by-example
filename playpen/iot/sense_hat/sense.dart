import 'dart:io';
import 'dart:typed_data';

/// LED 8x8 display, each LED is two bytes
final opcodes = ByteData.view(Uint16List(64).buffer);

main() {
  // Zero out the test device file
  File('test.bin').writeAsBytes(List.generate(64 * 2, (i) => 0));
  final buffer = FrameBuffer('test.bin');
  buffer.setPixel(0, 0, 0, 0, 0);
}

class FrameBuffer {
  String device;

  FrameBuffer([String fbDevice]) {
    device = fbDevice ?? _frameBufferDevice;
  }

  void setPixel(int x, int y, int r, int g, int b) async {
    assert(x >= 0 && x <= 7);
    assert(y >= 0 && y <= 7);
    assert(r >= 0 && r <= 255);
    assert(g >= 0 && g <= 255);
    assert(b >= 0 && b <= 255);

    final file = File(device);
    final writer = await file.open(mode: FileMode.write);
    final bytes = _createPixelBytes(r, g, b);
    await writer.writeFrom([upperByte(bytes), lowerByte(bytes)], (y * 8) + x);
    await writer.close();
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

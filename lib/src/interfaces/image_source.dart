import 'dart:typed_data';

abstract class IImageSource {
  Future<Uint8List?> getImageData();


}
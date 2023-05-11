import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../interfaces/image_source.dart';

class Camera  extends ImagePicker implements IImageSource{
  ImageSource imageSource = ImageSource.camera;
  double maxWidth;
  double maxHeight;
  Camera({this.maxWidth = 1800, this.maxHeight = 1800 }):super();

  @override
  Future<Uint8List?> getImageData() async{
    Uint8List imageBytes;
    XFile? pickedImage = await pickImage( source: imageSource, maxWidth: maxWidth, maxHeight: maxHeight,);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      imageBytes = await imageFile.readAsBytes();
      return imageBytes;
    }
    else { print('something went wrong'); return null;}
  }

}


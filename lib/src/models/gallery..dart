import 'dart:io';
import 'dart:typed_data';
import 'package:exif/exif.dart';
import 'package:image_picker/image_picker.dart';
import '../interfaces/image_source.dart';

class Gallery  extends ImagePicker implements IImageSource{
  ImageSource imageSource = ImageSource.gallery;
  double maxWidth;
  double maxHeight;
  Gallery({this.maxWidth = 300, this.maxHeight = 300}):super();

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

  double fractionToDouble(List<dynamic> coord){
    double doubleCordinate;
    Ratio grades = coord[0];
    Ratio mins = coord[1];
    Ratio secs = coord[2];
    doubleCordinate = -1*(grades.toDouble() + mins.toDouble()/60 + secs.toDouble()/3600);
    return doubleCordinate;
  }

}
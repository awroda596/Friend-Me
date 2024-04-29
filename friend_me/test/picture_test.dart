
import 'dart:typed_data';


import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friend_me/picture.dart';

//import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';





void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  


 /*

 const MethodChannel channel =
    MethodChannel('plugins.flutter.io/image_picker');

handler(MethodCall methodCall) async {
  ByteData data = await rootBundle.load("assets/images/Profile.png");
  Uint8List bytes = data.buffer.asUint8List();
  Directory tempDir = await getTemporaryDirectory();
  File file = await File(
    '${tempDir.path}/tmp.tmp',
  ).writeAsBytes(bytes);
  return file.path;
}
 
TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
    .setMockMethodCallHandler(channel, handler);
*/
    test (
      'Given picture class, when initialized the value of _profile should be false',
      ()  {
        Picture pic = Picture();
        bool check = pic.checkPhoto();
        expect(check, false);

      },
    );

    test (
      'Given picture class, when initialized the value of _background should be false',
      ()  {
        Picture pic = Picture();
        bool check = pic.checkBackground();
        expect(check, false);

      },
    );

     test (
      'Given picture class, when initialized, calling the getPics should set _picture to false',
      ()  {
        Picture pic = Picture();
        pic.getPics();
        bool check = pic.checkPhoto();
        expect(check, false);

      },
    );

     test (
      'Given picture class, when initialized, calling the getPics should set _background to false',
      ()  {
        Picture pic = Picture();
        pic.getPics();
        bool check = pic.checkBackground();
        expect(check, false);

      },
    );


    test (
      'Given picture class, when initialized, calling the getProfilePhoto should return a new uint8 list with values of zero',
      ()  {
        Picture pic = Picture();
        Uint8List value = Uint8List(8);
        value = pic.getProfilePhoto();
        expect(value, Uint8List(8));

      },
    );


    test (
      'Given picture class, when initialized, calling the getProfileBackground should return a new uint8 list with values of zero',
      ()  {
        Picture pic = Picture();
        Uint8List value = Uint8List(8);
        value = pic.getProfileBackground();
        expect(value, Uint8List(8));

      },
    );





}









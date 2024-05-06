


import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friend_me/picture.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';



//import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'picture_test.mocks.dart';


@GenerateMocks([ImagePicker])

void main(){
  TestWidgetsFlutterBinding.ensureInitialized(); 
  late MockImagePicker mockImagePicker;

   setUp(() {
     mockImagePicker = MockImagePicker();
     SharedPreferences.setMockInitialValues({});
    });
  
  group("constructor and initial values", () {

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
      'Given picture class, when initialized, calling the getPics with no photo saved should set _picture to false',
      ()  {
        Picture pic = Picture();
        pic.getPics();
        bool check = pic.checkPhoto();
        expect(check, false);

      },
    );

     test (
      'Given picture class, when initialized, calling the getPics with no photo saved should set _background to false',
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
        expect(value, [0, 0, 0, 0, 0, 0, 0, 0]);

      },
    );

    test (
      'Given picture class, when initialized, calling the getProfileBackground should return a new uint8 list with values of zero',
      ()  {
        Picture pic = Picture();
        Uint8List value = Uint8List(8);
        value = pic.getProfileBackground();
        expect(value, [0, 0, 0, 0, 0, 0, 0, 0]);

      },
    );

   });


   
  group("getprofilephoto and getprofilebackground", () {

     

      test (
      'Given picture class, when initialized, calling the getProfileBackground should return a Uint8List of the photo if saved',
      ()  async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);
        await pic.getPhoto();
        await pic.getPics();
        var actual = pic.getProfilePhoto();
        expect(actual, bytes);

      },
    );

    
      test (
      'Given picture class, when initialized, calling the getProfileBackground should return a Uint8List of the photo if saved',
      ()  async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);
        await pic.getBackground();
        await pic.getPics();
        var actual = pic.getProfileBackground();
        expect(actual, bytes);

      },
    );

     test (
      'Given picture class, when photo is changed, getprofilephoto should return the second photo as uint8list',
      ()  async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final ByteData dataSecond = await rootBundle.load('assets/images/Profile_template.png');
        final Uint8List bytesSecond = dataSecond.buffer.asUint8List();
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        XFile? photoToMoclSecond = XFile.fromData(bytesSecond);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);
        await pic.getPhoto();
        await pic.getPics();

        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMoclSecond);

        await pic.getPhoto();
        await pic.getPics();

        var actual = pic.getProfilePhoto();
        expect(actual, bytesSecond);

      },
    );

     test (
      'Given picture class, when background is changed, getprofilebackground should return the second photo as uint8list',
      ()  async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final ByteData dataSecond = await rootBundle.load('assets/images/Profile_template.png');
        final Uint8List bytesSecond = dataSecond.buffer.asUint8List();
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        XFile? photoToMoclSecond = XFile.fromData(bytesSecond);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);
        await pic.getBackground();
        await pic.getPics();

        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMoclSecond);

        await pic.getBackground();
        await pic.getPics();

        var actual = pic.getProfileBackground();
        expect(actual, bytesSecond);

      },
    );


  });



  group("getImage function", () {
    
     test (
      
      'Given picture class, when initialized, calling the getImage returns the provided image',
      () async {
        Picture pic = Picture(mockImagePicker);
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);
        var temp = await pic.getImage();
        expect(temp, photoToMocl);

      },
    );

      test (
      'Given picture class, when getImage is called with null image, returns null',
      () async {
        Picture pic = Picture(mockImagePicker);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => null);
        var temp = await pic.getImage();
        expect(temp, null);
      },
    );
  });


  group("getPhoto and getBackground function", () {
     
     test (
      'Given picture class, when initialized, calling the getPhoto calls getimage and saves it',
      () async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);

        await pic.getPhoto();
        await pic.getPics();
        bool actual = pic.checkPhoto();
        expect(actual, true);

      },
    );

    test (
      'Given picture class, when initialized, calling the getBackground calls getimage and saves it',
      () async {
        Picture pic = Picture(mockImagePicker);
        
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);

        await pic.getBackground();
        await pic.getPics();
        bool actual = pic.checkBackground();
        expect(actual, true);

      },
    );

     test (
      'Given picture class, when initialized, calling the getBackground does not save if pic is null',
      () async {
        Picture pic = Picture(mockImagePicker);
        
        // mocked image picker
       
        XFile? photoToMocl;
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);

        await pic.getBackground();
        await pic.getPics();
        bool actual = pic.checkBackground();
        expect(actual, false);

      },
    );

       test (
      'Given picture class, when initialized, calling the getphoto does not save if pic is null ',
      () async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        XFile? photoToMocl;
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);
        await pic.getPhoto();
        await pic.getPics();
        bool actual = pic.checkPhoto();
        expect(actual, false);

      },
    );

  });


  
  group("check photo and check background", () {


    test (
      'Given picture class, when calling getbackground and not getphoto, calling the checkphoto function after should return false',
      () async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);

        await pic.getBackground();
        await pic.getPics();
        bool actual = pic.checkPhoto();
        expect(actual, false);

      },
    );

      test (
      'Given picture class, when calling getphoto and not getbackground, calling the checkbackground function after should return false',
      () async {
        Picture pic = Picture(mockImagePicker);
        // mocked image picker
        final ByteData data = await rootBundle.load('assets/images/Profile.png');
        final Uint8List bytes = data.buffer.asUint8List();
        XFile? photoToMocl = XFile.fromData(bytes);
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => photoToMocl);

        await pic.getPhoto();
        await pic.getPics();
        bool actual = pic.checkBackground();
        expect(actual, false);

      },
    );






  });

}









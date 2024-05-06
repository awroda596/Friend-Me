
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Picture {


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ImagePicker _imagePicker;
 

 // Private constructor in case imagepicker is passed
  Picture._(this._imagePicker);

    // Factory method with a default ImagePicker
  factory Picture([ImagePicker? imagePicker]) {
    return Picture._(imagePicker ?? ImagePicker());
  }

  bool _background = false;
  bool _profile = false;


  Uint8List _webProfileImage = Uint8List(8);
  Uint8List _webBackgroundImage = Uint8List(8);


  Future<XFile?> getImage() async{
   
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }


  Future<void> getPics() async {
    String profilePic = await  _prefs.then((SharedPreferences prefs){
      return (prefs.getString('profilePic') ?? 'NULL');
    });
    String backgroundPic = await  _prefs.then((SharedPreferences prefs){
      return (prefs.getString('backgroundImage') ?? 'NULL');
    });
    if (profilePic == 'NULL'){
      _profile = false;
    }
    else{
      _profile = true;
      _webProfileImage = base64Decode(profilePic);
    }
   if (backgroundPic == 'NULL'){
      _background = false;
    }
    else{
      _background = true;
      _webBackgroundImage = base64Decode(backgroundPic);
    }
  }


  Future<void> getPhoto() async{
      XFile? image = await getImage();
      if (image != null){
        final SharedPreferences prefs = await _prefs;
        var web = await image.readAsBytes();
        String base64Image = base64Encode(web);
        bool success = false;
        success = await prefs.setString("profilePic", base64Image);
        if (!success){
            if (kDebugMode) {
              print("profile Pic not saved");
            }
        }
      }
      else {
        if (kDebugMode) {
          print("No image was selected");
        }
      }
  }


    Future<void>  getBackground() async{
      XFile? image = await getImage();
      if (image != null){
        final SharedPreferences prefs = await _prefs;
        var web = await image.readAsBytes();
        String base64Image = base64Encode(web);
        bool success = false;
        success = await prefs.setString("backgroundImage", base64Image);
        if (!success){
            if (kDebugMode) {
              print("profile Pic not saved");
            }
        }
      }
      else {
        if (kDebugMode) {
          print("No image was selected");
        }
      }
    

  }

  Uint8List getProfilePhoto()  {
    return _webProfileImage;
  }

   Uint8List getProfileBackground(){
    return _webBackgroundImage;
  }

  bool checkPhoto(){
    return _profile;
  }

  bool checkBackground(){
    return _background;
  }



}
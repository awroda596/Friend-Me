
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Picture {


 final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

   bool _background = false;
   bool _profile = false;


  Uint8List _webProfileImage = Uint8List(8);
  Uint8List _webBackgroundImage = Uint8List(8);


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
    if(kIsWeb){
      final SharedPreferences prefs = await _prefs;
      bool success = false;
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null){
        var web = await image.readAsBytes();
        String base64Image = base64Encode(web);
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
  }


    Future<void>  getBackground() async{
     if(kIsWeb){
      final SharedPreferences prefs = await _prefs;
      bool success = false;
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null){
        var web = await image.readAsBytes();
        String base64Image = base64Encode(web);
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
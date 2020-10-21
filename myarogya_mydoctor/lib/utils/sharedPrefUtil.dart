

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {

  storeString(String key, String value) async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(key,value);
  }
 readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String value= pref.getString(key);
    return value;
  }
}
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_delivery/core/constants/failures.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthLocal{
  final SharedPreferences sharedPreferences;

  AuthLocal(this.sharedPreferences);
  int? getId(){
    try{
      return sharedPreferences.getInt("id");
    }
        catch(e){
      throw CacheFailure();
        }
  }
  bool isSignIn(){
    try{
      final int? id=getId();
      return id==null?false:true;
    }
    catch(e){
      throw CacheFailure();
    }
  }
  void signIni(int id){
    try{
      sharedPreferences.setInt("id", id);
      FirebaseMessaging.instance.subscribeToTopic("deliveries");
    }
    catch(e){
      throw CacheFailure();
    }
  }

  void signOut(){
    try{
      sharedPreferences.remove("id");
      FirebaseMessaging.instance.unsubscribeFromTopic("deliveries");
    }
        catch(e){
      throw CacheFailure();
        }
  }


}
import 'dart:core';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppDatabase{
  bool hiveDbLoaded=false;
  // ::::::::::::: result of checkFirstTimeLogIn()
  int firstTimeLogin=0;
  Map hiveDbBoxes={
    "systemParameters":"","userBox":"", "contactsBox":"","settingsBox":"","postBox":"",
    "messagesBox":"","notificationsBox":"","toolsBox":"", "eventsBox":"","locationsBox":"",
    "recentMessengers":"","contactsInfo":""
  };
  int checkFirstTimeLogIn(){
    int result=1;

    return result;
  }
  // :::::::::::; load database
  Future loadHiveDB( )async{
    if(hiveDbLoaded==false){
      // ::::::::::::: catch hive initialization exceptions
      try{
        WidgetsFlutterBinding.ensureInitialized();
        final hiveDir=await getApplicationDocumentsDirectory();
        Hive.init(hiveDir.path+ '/hii');
        // ::::::::::::: after initializing hive database, check for user box storage to see if it exists
        // ::::::::::::: if it does not exist, then the user is logging in for the first time
        if(checkFirstTimeLogIn()==1){
          // ::::::::::::::::: await hiveDbBoxes["recentMessengers"].clear();
          // ::::::::::::::::: if its true, it means user is logging in for the firs time
          // ::::::::::::::::: so since the user is logging in for the first  time we have to build the database boxex
          // ::::::::::::::::: to hold data on the device
          hiveDbBoxes["systemParameters"]=await Hive.openBox('systemParameters');
          hiveDbBoxes["userBox"]=await Hive.openBox('user');
          hiveDbBoxes["contactsBox"]=await Hive.openBox('contacts');
          hiveDbBoxes["settingsBox"]=await Hive.openBox('settings');
          hiveDbBoxes["postBox"]=await Hive.openBox('post');
          hiveDbBoxes["messagesBox"]=await Hive.openBox('messages');
          hiveDbBoxes["notificationsBox"]=await Hive.openBox('notifications');
          hiveDbBoxes["toolsBox"]=await Hive.openBox('tools');
          hiveDbBoxes["eventsBox"]=await Hive.openBox('events');
          hiveDbBoxes["locationsBox"]=await Hive.openBox('locations');
          hiveDbBoxes["recentMessengers"]=await Hive.openBox('recentMessengers');
          hiveDbBoxes["contactsInfo"]=await Hive.openBox('contactsInfo');
          await hiveDbBoxes["recentMessengers"].clear();
        }
        // bool exists = await Hive.boxExists('boxName');
        print("total contacts: "+hiveDbBoxes["contactsBox"].length.toString());
        hiveDbLoaded=true;
      }catch(databaseFailEx){

      }
    }
    hiveDbLoaded=true;
    return hiveDbBoxes;
  }
  void authenticateUserLogin(){

  }
  void clearHiveDatabase(){

  }
  // :::::::::::::: initialize app database for each session
  Future initAppDatabase()async{

    //Hive.clear();
  }
}
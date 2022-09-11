//import 'package:owili/app_screens/screen_feed.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
//import 'package:owili/attendance/recognitionCamera.dart';
import 'main_banner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:async';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'dart:typed_data';
//import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import '../helperLibraries/uiHelper.dart';
import '../helperLibraries/hiveDatabase.dart';
import 'home.dart';
class ScreenSplash extends StatefulWidget{
  List<CameraDescription>  cameras= [];
  Map hiveDbBoxes={};
  ScreenSplash({Key key }) : super(key: key);
  @override
  ScreenSplashState createState()=>ScreenSplashState(cameras);
}
class ScreenSplashState extends State<ScreenSplash>{
  UIParameters uiParametersInstance=new UIParameters();
  AppDatabase appDatabase = new AppDatabase();
  List cameras;
  ScreenSplashState(this.cameras);
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int isLoggedIn=0;
  int password=1;
  bool appSplashVisible=true;
  bool signInViewVisible=false;
  bool homeViewVisible=false;
  bool fetchedBackendData=false;
  List contactCharsList=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","S","Y","Z","#"];
  List contactListModel=[];
  var totalContacts=0;
  List holdContacts=[];
  var dbContacts;
  bool hiveDbLoaded=false;
  Map hiveDbBoxes={
    "systemParameters":"","userBox":"",
    "contactsBox":"","settingsBox":"","postBox":"",
    "messagesBox":"","notificationsBox":"","toolsBox":"",
    "eventsBox":"","locationsBox":"",
    "recentMessengers":"","contactsInfo":""

  };
  var hiveDbInstance;
  void main(){

  }
  checkFirstTimeLogIn(){
    return 1;
  }
  void loadHiveDB()async{
    if(hiveDbLoaded==false){
      WidgetsFlutterBinding.ensureInitialized();
      final hiveDir=await getApplicationDocumentsDirectory();
      Hive.init(hiveDir.path+ '/hii');
      //Hive.clear();
      if(checkFirstTimeLogIn()==1){
       // await hiveDbBoxes["recentMessengers"].clear();
        //----if its true, it means user is loggin in for the firs time
        //----so since the user is loggin in for the first  time we habe to build the boxex
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
      print("contact box length: "+hiveDbBoxes["contactsBox"].length.toString());
      hiveDbLoaded=true;
    }
    hiveDbLoaded=true;
  }

  storeImageByte(String avatar)async{
    Uint8List imageBytes = await networkImageToByte(avatar);
    var temp=base64Encode(imageBytes);
    return temp.toString();
  }
  //-------use api web response to populate hive contact db data
  getStringWeight(var stringValue){
    var result="";
    for(int i=0; i<stringValue.length; i++){
      result=result+stringValue.codeUnitAt(i).toString();
    }
    return result;
  }
  loadContactsIntoHive(var jsonData){
      for(var list=0; list<jsonData.length; list++){
        //----iterate to put contact list
        var user_names_=jsonData[list]["username"];
        String user_photos=jsonData[list]["avatar"];
        var userID=jsonData[list]["userID"];
        var contactType=jsonData[list]["contactType"];
        var photoType=1;
        Uint8List imageByteList;
        if(user_photos!=""){
          storeImageByte(user_photos).then((data){
            user_photos=data;
          });
          Map listNow={"username":user_names_,"avatar":user_photos,"userID":userID,"contactType":contactType,"photoType":photoType};
          print(user_photos);
          hiveDbBoxes["contactsBox"].put("username"+list.toString(),listNow);
          //-----populate contacts info
          Map contactInfoList={"username":user_names_,"avatar":user_photos,"userID":userID,"contactType":contactType,"photoType":photoType};
          print(user_photos);
          hiveDbBoxes["contactsInfo"].put(getStringWeight(user_names_),contactInfoList);
        }else{
          Map listNow={"username":user_names_,"avatar":user_photos,"userID":userID,"contactType":contactType,"photoType":photoType};
          print(user_photos);
          hiveDbBoxes["contactsBox"].put("username"+list.toString(),listNow);
          //-----populate contacts info
          Map contactInfoList={"username":user_names_,"avatar":user_photos,"userID":userID,"contactType":contactType,"photoType":photoType};
          hiveDbBoxes["contactsInfo"].put(getStringWeight(user_names_),contactInfoList);
        }
      }
  }
  
  createHivebox(String boxValue)async{
    var boxResult=await Hive.openBox(boxValue);
    return boxResult;
  }
  //-------use api web response to populate hive message db data
  loadMessagesIntoHive(var jsonData)async{
    print("load messages");
    //---list = index of discussion
    for(var list=0; list<jsonData.length; list++){
      //-------iterate  contact discussion list holder ---------
      String messageKey=jsonData[list].keys.toList()[0].toString();//----the discussion key, the person user is chatting with
      var totalDiscussionBetween=jsonData[list][messageKey].length;//----the length of discussion messages between this user
      createHivebox(messageKey).then((result){
        //-----after opening box, we can clear before adding data
        //result.clear();
        print("box created");
        for(var eachContact=0; eachContact<totalDiscussionBetween; eachContact++){
          //---------iterate messages and add to list
          var username=jsonData[list][messageKey][eachContact]["username"];
          var sender=jsonData[list][messageKey][eachContact]["sender"];
          var receiver=jsonData[list][messageKey][eachContact]["receiver"];
          var messageContent=jsonData[list][messageKey][eachContact]["messageContent"];
          var messageType=jsonData[list][messageKey][eachContact]["messageType"];
          var messageDate=jsonData[list][messageKey][eachContact]["messageDate"];
          var messageTime=jsonData[list][messageKey][eachContact]["messageTime"];
          Map listNow={"username":username,"sender":sender,"receiver":receiver,"messageContent":messageContent,"messageType":messageType,"messageDate":messageDate,"messageTime":messageTime};
          //print(listNow);
          result.put(eachContact,listNow);
          //--------add the last message to recent messenger list
          if(eachContact==totalDiscussionBetween-1){
            Map recentMessageListNow={"username":username,"sender":sender,"receiver":receiver,"messageContent":messageContent,"messageType":messageType,"messageDate":messageDate,"messageTime":messageTime};
            hiveDbBoxes["recentMessengers"].add(recentMessageListNow);
            //print(recentMessageListNow);
          }
        }
      });

    }
  }
  Future webRequest(context)async{
    if(fetchedBackendData==false){
      print("web request");
      final Uri contactsUrl = Uri.parse('https://www.longtact.com/api_container/broker_contacts_API.php');
      final Uri messageListURL=  Uri.parse('https://www.longtact.com/api_container/broker_allContactMessagesList_API.php');
      Map<String,dynamic> contactArgsJson(){
        final Map<String,dynamic> postData=new Map<String,dynamic>();
        postData["name"]="name val";
        postData["color"]="color val";
        return postData;
      }
      Map<String,dynamic> messageArgsJson(){
        final Map<String,dynamic> postData=new Map<String,dynamic>();
        postData["userRequestingID"]="name val"; //---userid
        postData["param1"]="color val";
        return postData;
      }
      var client = http.Client();
      var contactResponse= await client.post(contactsUrl,headers:{"Content-Type":"application/json"}, body:json.encode(contactArgsJson()) );
      var messageListResponse=await client.post(messageListURL,headers:{"Content-Type":"application/json"}, body:json.encode(messageArgsJson()) );

      try {
        //------populate hive contacts
        print('Response status: ${contactResponse.statusCode}');
        var contactsData=jsonDecode(contactResponse.body);
        loadContactsIntoHive(contactsData);
        //-----populate hive chat messages
        print('Response status: ${messageListResponse.statusCode}');
        var messagesData=jsonDecode(messageListResponse.body);
       // print(messagesData.toString());
        loadMessagesIntoHive(messagesData);

      }catch(SocketException){} finally {
        fetchedBackendData=true;
        client.close();
      }
      fetchedBackendData=true;
    }
    //print(await http.read('http://127.0.0.1/appAPI/broker_contacts_API.php'));
  }

String text='';
  var timeout = const Duration(seconds: 5);
  var ms = const Duration(milliseconds: 1);
  int checkSignedIn(){
    return 0;
  }
  int verifyUserPassword(passedValue,dbValue){
    if(passedValue==dbValue){
      print("logged in");
      nameController.text="";
      passwordController.text="";
      appSplashVisible=false;
      signInViewVisible=false;
      homeViewVisible=true;
      isLoggedIn=1;
      setState(() {

      });
      return 1;

    }else{

    }
    return 0;
  }
  startTimeout([ int milliseconds=2000]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, showAuthenticationPage);
  }
  void showAuthenticationPage() {  // callback function
    /***
     * when the splash screen stays for 4 secs i launch sign up or main page
     * ***/
    setState(() {
      if(checkSignedIn()==0){
        /***---
         * if the user has not logged in already, take them to the sign in page
         * ***/
        appSplashVisible=false;
        signInViewVisible=true;
      }else{

      }
    });
    //print("timer completed");
  }
  Container signInView(context){

    return Container(
        //padding: EdgeInsets.all(0),
       color: uiParametersInstance.appYellow,
        width:MediaQuery.of(context).size.width*100/100,
        height: MediaQuery.of( context).size.height*100/100,
        child: ListView(
          children: <Widget>[
            Container(
              height: 20.0,
            ),
            Container(
              height: 200,
              width:MediaQuery.of(context).size.width*100/100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text( 'Yopipi',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.notoSans(textStyle:    TextStyle(
                    color: Color(0xff404040),letterSpacing: 0.2, height:1.0,
                    fontSize: 22,fontWeight:FontWeight.w800,
                    decoration: TextDecoration.none,
                  ), ),
                ),
            ),

            Container(
              child: Container(
                margin: EdgeInsets.fromLTRB(30.0,20,0,40), child: Container(
                child:  Text( "Welcome back,", textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(textStyle:    TextStyle(
                    color:Color(0xff505050),letterSpacing: 0.0, height:1.0,
                    fontSize: 14,fontWeight:FontWeight.w400, decoration: TextDecoration.none,
                  ), ),
                ),
              ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(left:30.0,right:30.0,top:0.0,bottom:20.0,),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20, minHeight: 50, maxWidth:MediaQuery.of(context).size.width*28/100, maxHeight: 150,
                ),
                child: Container(
                  //width:200,
                  padding: EdgeInsets.only(left:10.0,right:10.0,top:10.0,bottom:0.0,),
                  margin: EdgeInsets.fromLTRB(0.0,2,0,0),
                  decoration: BoxDecoration( border: Border.all(color: uiParametersInstance.beautifulColor, width: 2.0,
                  ),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)), color: Color(0xfffcfcfc),
                  ), //color: Color(0xfffcfcfc),
                  child: new TextField(
                    decoration: InputDecoration.collapsed(
                      border: InputBorder.none, hintText: 'Username, Phone number ',hintStyle: TextStyle(
                      fontSize: 14.0,  color: Color(0xffaaaaaa),fontWeight: FontWeight.w500,
                    ),),
                    style: TextStyle(
                      fontSize: 14.0, color: Color(0xff202020),fontWeight: FontWeight.w600,
                    ),
                    //onChanged: (value) => updateButtonState(value),
                    autofocus: false,
                    //focusNode: _focusNode,
                    maxLines: null, controller: nameController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(left:30.0,right:30.0,top:0.0,bottom:0.0,),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20, minHeight: 50, maxWidth:MediaQuery.of(context).size.width*28/100, maxHeight: 150,
                ),
                child: Container(
                  //width:200,
                  padding: EdgeInsets.only(left:10.0,right:10.0,top:10.0,bottom:0.0,),
                  margin: EdgeInsets.fromLTRB(0.0,2,0,0),
                  decoration: BoxDecoration( border: Border.all(color: uiParametersInstance.beautifulColor, width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)), color: Color(0xfffcfcfc),
                  ), //color: Color(0xfffcfcfc),
                  child: new TextField(
                    decoration: InputDecoration.collapsed(
                      border: InputBorder.none, hintText: 'Password ',hintStyle: TextStyle(
                      fontSize: 14.0,  color: Color(0xffaaaaaa),fontWeight: FontWeight.w500,
                    ),),
                    style: TextStyle(
                      fontSize: 14.0, color: Color(0xff202020),fontWeight: FontWeight.w600,
                    ),
                    //onChanged: (value) => updateButtonState(value),
                    autofocus: false,obscureText: true,enableSuggestions: false,  obscuringCharacter: "*",
                    autocorrect: false,
                     //focusNode: _focusNode,
                    maxLines: 1, controller: passwordController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ),

            Container(
                height:50.0, margin:EdgeInsets.only(
              left:10.0, right:10.0,bottom:30.0,top:30.0,
            ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment:  CrossAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: (){
                      //forgot password screen
                    },
                    textColor: Color(0xff404040),
                    child: Text('Forgot Password',style:TextStyle(color:Color(0xff404040), fontSize: 15,fontWeight:FontWeight.w600,
                      decoration: TextDecoration.none,
                      ),),
                  ),

              Padding( padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0),
                  ),
                 child: Container(
                    //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height:50.0, width:140.0,
                     //color: Color(0xff16a085),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xfffcfcfc),
                    child: Text('Login', style: TextStyle(color:Color(0xff404040), fontSize: 20,fontWeight:FontWeight.w800,
                      decoration: TextDecoration.none,
                    ), ),
                    onPressed: () {
                      appSplashVisible=false;
                      signInViewVisible=false;
                      homeViewVisible=true;
                      setState(() {

                      });
                      print(nameController.text);
                      print(passwordController.text);
                      verifyUserPassword(passwordController.text, "1");
                    },
                  )
                  )
                  )
              )
                ],
              ),
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin:EdgeInsets.only(
                        left:80.0, right:10.0,bottom:30.0,
                      ),
                      child: Text('Not already a User?'),
                      ),
                  ],
                )
            ),
            Container(
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    child:Container(
                        //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height:50.0, width:280.0, color: Color(0xfff1f1f1),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Color(0xfffcfcfc),
                          child: Text('Signup', style: TextStyle(color:Color(0xff404040), fontSize: 20,fontWeight:FontWeight.w500,
                            decoration: TextDecoration.none,
                          ), ),
                          onPressed: () {
                            //signup screen
                          },
                        )
                    ),
            )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
            )
          ],
        ));
  }
  Container AppSplash(context){
    startTimeout();
    return Container(
      //width:40,
      //height: 40,//Color(0xff16a085)
      color: Colors.transparent,
      width:MediaQuery.of(context).size.width*100/100,
      height:MediaQuery.of(context).size.height*100/100,
      padding:EdgeInsets.all(0.0),
      //margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          /***
           *
           * ***/
          Container(
            height:MediaQuery.of(context).size.height*40/100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
            Container(
              height:100,
            ),
                Container(
                  //IcoFontIcons.heartAlt, //icon usage
                  margin:EdgeInsets.only(
                    left:10.0, right:10.0,bottom:30.0,
                  ),
                  width:MediaQuery.of(context).size.width*100/100,
                  child: Container( height:80.0, width:80.0, child:
                  //Image.asset("assets/images/icons8-reading-menu.png",fit:BoxFit.contain,
                  Image.asset('assets/images/flutter-logo.png',fit:BoxFit.contain,width: 20,height:20,),
                  ),
                ),
                Container(
                  margin:EdgeInsets.only(
                  left:10.0, right:10.0,top:30.0,
                  ),
                  child: Text('Flutter and Nodejs', style: TextStyle(color:Color(0xffcccccc), fontSize: 24,fontWeight:FontWeight.w600,
                  decoration: TextDecoration.none,
                  ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height:MediaQuery.of(context).size.height*40/100,
            child:Column(
              children: [
                Container(
                  margin:EdgeInsets.only(
                    left:10.0, right:10.0,top:MediaQuery.of(context).size.height*30/100,
                  ),
                  child: Text('Flutter, Nodejs Assessment',textAlign: TextAlign.center, style: TextStyle(color:Color(0xffdddddd), fontSize: 14,fontWeight:FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  ),
                ),
                Container(
                  margin:EdgeInsets.only(
                    left:10.0, right:10.0,top:10.0,
                  ),
                  //alignment: Alignment(1.0,1.0),
                  child: Text('Flutter、Nodejs 评估',textAlign: TextAlign.center, style: TextStyle(color:Color(0xffdddddd), fontSize: 14,fontWeight:FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Scaffold appLaunched(context){
    /*
    appSplashVisible=false;
    signInViewVisible=false;
    homeViewVisible=true;
    setState(() {

    });
    */
    return new Scaffold(
      backgroundColor: Color.fromRGBO(0,8,20,1),
      body: Center(
        /****
         * Center has a child of row which has three children
         * 1. splash screen
         * 2. sign up page
         * 3. main page
         * ***/
        child: Container(
          width: MediaQuery.of(context).size.width*100/100,
          height: MediaQuery.of( context).size.height*100/100,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            /***
             * splash screen , the screen that pops after opening the app
             * **/
            Visibility(
              visible: appSplashVisible, maintainAnimation: true,maintainSize: false,maintainState: true,
              child: Container(
                height: MediaQuery.of( context).size.height*100/100,
                child:AppSplash(context),
              )

            ),
            /***
             * sign up screen comes up when user is needed to sign in , the screen that pops after opening the app
             * **/
            Visibility(
              visible: signInViewVisible, maintainAnimation: true,maintainSize:false,maintainState: true,
              child: Container(
                height: MediaQuery.of( context).size.height*100/100,

                child:  ScreenAppHome( ),
              )
             ),

            /***
             * screen after the user has signed in , the screen that pops after opening the app
             * **/
            Visibility(
              //child:AppSplash(context),
              //visible: homeViewVisible,
              //child:homeView(context),
              //child:Container(),
              visible: homeViewVisible, maintainAnimation: true,maintainSize: false,maintainState: true,
              child: Container(
                height: MediaQuery.of( context).size.height*100/100,

                child:  ScreenAppHome( ),
              )
              //NavState(cameras: [],hiveDbBoxes:hiveDbBoxes),
            ),

          ],
        ),
      ),

      )
    );
  }
  Scaffold signUp(){
    return new Scaffold(

    );
  }
  @override
  Widget build(BuildContext context){
    uiParametersInstance.initUIParameters(MediaQuery.of( context).size.width, MediaQuery.of( context).size.height, 1, 1);
    isLoggedIn=0;
    /***
     * Load all the data required for the app to work
     * ***/
    appDatabase.loadHiveDB();
    hiveDbBoxes=appDatabase.hiveDbBoxes;
    //loadHiveDB();
    //webRequest(context);

    FlutterStatusbarTextColor.setTextColor(FlutterStatusbarTextColor.dark);
    if(isLoggedIn==0){
      /***
       * When the app is first opened, check if the user is already logged in
       * if the user is not logged in, then show the splash and sign in page
       * ***/
      return appLaunched(context);
    }else if(isLoggedIn==1){
      /***
       * When the app is first opened, check if the user is already logged in
       * if the user is logged in, bring him to the main page
       * the gets checked again on set state, so if the user gets logged in successfully
       * This is the home page which has link to other screens, other screen change states from this screen
       * ***/

      return ScreenAppHome( );
      //return Scaffold();

    }

  return Text(text);

  }
}
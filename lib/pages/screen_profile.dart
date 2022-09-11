import 'package:flutter/material.dart';
//import 'package:tflite/tflite.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helperLibraries/uiHelper.dart';



class ScreenProfile extends StatelessWidget{
  var uiParametersInstance=new UIParameters();

  @override
  Widget build(BuildContext context){
    uiParametersInstance.initUIParameters(MediaQuery.of( context).size.width, MediaQuery.of( context).size.height, 1, 1);

    return  Stack(
        children:[
          Positioned( top:0,
          child: Container(
          //decoration: uiParametersInstance.mainDecoration,
            height:uiParametersInstance.getUIHeight(null), width:uiParametersInstance.getUIWidth(null),
            child: Scaffold(

              backgroundColor: uiParametersInstance.appYellow,
              appBar: AppBar(

                backgroundColor: Colors.transparent, elevation: 0.0, titleSpacing: 0, leading: null, bottomOpacity: 0.4,
                title: Container(

                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Container(
                          alignment: Alignment(0.0,0.0), padding:EdgeInsets.all(2.0), margin: EdgeInsets.all(6.0),
                          child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width:MediaQuery.of(context).size.width*50/100,
                                  padding:EdgeInsets.all(0.0), margin: EdgeInsets.all(8.0),
                                  child:
                                  uiParametersInstance.getAppLabelTextTemplate(context, "Account", 20),
                                ),
                              ]
                          )
                      ),

                    ]
                ),),
              ),
              body: Center(
                child:Container(
                    color:uiParametersInstance.appYellow,
                  child:ListView(
                    padding: EdgeInsets.all(0.0),
                    children: <Widget>[
                      //----profile row
                      Container(
                        height: 20.0, color:uiParametersInstance.appYellow, margin: EdgeInsets.only(top:20.0, ),
                      ),
                      Container(

                        height:60.0,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*70/100, height:60.0,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:60.0, width:60.0,
                                      child: Container(
                                        width:40,height: 40, padding:EdgeInsets.all(0.0), margin: EdgeInsets.all(6.0),
                                        child: ClipRRect(borderRadius:BorderRadius.circular(uiParametersInstance.avatarRadius),
                                          child:  Image.asset('assets/images/pat.png',
                                          ),
                                        ),
                                      ),),
                                    Container(
                                      width:130.0,  padding: EdgeInsets.fromLTRB(4,0,0,0), margin: EdgeInsets.only( bottom:2.0, ),
                                      child: Text('Agent Patterson', style: TextStyle(
                                        color: Colors.black87, fontSize: 15,fontWeight:FontWeight.w500,height: 3.0,
                                        decoration: TextDecoration.none,
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width*20/100,height:60.0,
                                  padding: EdgeInsets.fromLTRB(10,0,10,0),
                                  // margin: EdgeInsets.only(top:2.0, ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.mode_edit,size:25.0,color:Colors.black87,
                                          ),
                                          onPressed: ( ){

                                          },
                                        ),
                                      ]
                                  )
                              ),
                            ]
                        ),
                      ),
                      Container(
                        //color:Color(0xffffffff),
                        height: 800.0,  width:  MediaQuery.of( context).size.width*100/100,
                      ),

                      //this class is a widget which contains the second section of adverts...inside of second_advert.dart
                    ],
                  )
              ),),
              //the navigation bar is in bottom_navigation.dart..
              //bottomNavigationBar: new NavState(),//the navigation bar
            ),




          ),
          )

        ],

    );





  }
}
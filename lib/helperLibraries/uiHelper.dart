import 'package:flutter/material.dart';
class UIParameters{
  double screenWidth=0.0;
  double screenHeight=0.0;
  double avatarRadius=18.0;
  double userCommentReplyAvatarRadius=10.0;
  double  groupInfoFontSize=13.0;
  double navigationIconOpacity=0.8;
  double defaultMembersListTopMargin=540.0;
  double appTitleFontSize=20.0;

  // :::::: longtact-theme-app-yellow
  String appYellowMapEnglishUrl="https://api.mapbox.com/styles/v1/potential/ckqfgmhs94rwf17nwpgp7v00n/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicG90ZW50aWFsIiwiYSI6ImNqdXhqbHhtaTBuc3MzeW8wcTVndjgwYWsifQ.ZyAIH5bI_DG5kn4DInZe6w";
  String appYellowMapChineseUrl="https://api.mapbox.com/styles/v1/potential/ckqfgerfk61n417o7v0h8jy3z/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicG90ZW50aWFsIiwiYSI6ImNqdXhqbHhtaTBuc3MzeW8wcTVndjgwYWsifQ.ZyAIH5bI_DG5kn4DInZe6w";
  String appSatelliteViewMapUrl="https://api.mapbox.com/styles/v1/potential/ckmjker730s4m17oa9z3k13e6/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicG90ZW50aWFsIiwiYSI6ImNqdXhqbHhtaTBuc3MzeW8wcTVndjgwYWsifQ.ZyAIH5bI_DG5kn4DInZe6w";
  String appNightViewMapUrl="";
  // :: previous map theme
  // "https://api.mapbox.com/styles/v1/potential/ckmij9knz1in017qv2yuj3n9d/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicG90ZW50aWFsIiwiYSI6ImNqdXhqbHhtaTBuc3MzeW8wcTVndjgwYWsifQ.ZyAIH5bI_DG5kn4DInZe6w"
  Decoration mainDecoration=  BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.topRight,
      colors: [ Color(0xffbdb2ff), Color(0xffbdb2ff).withOpacity(0.7),
    ],)
  );
  Decoration middleDecoration=  BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight, end: Alignment.topLeft,
        colors: [ Color(0xff64dfdf), Color(0xffffd166),
      ],)
  );
  Decoration homeCreateMenuDecoration=  BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight, end: Alignment.topLeft,
        colors: [ Color(0xff3d5a80), Color(0xff48bfe3),
      ],)
  );
  getAppLabelTextTemplate(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-SemiBold',  fontSize: 18,
        decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.1,
      ),
    );
  }
  getAnnouncementGroupTextTemplate(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-SemiBold',  fontSize: 11,
        decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.0,
      ),
    );
  }
  getAnnouncementGroupTitleViewTextTemplate(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-SemiBold',  fontSize: 12,
        decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
      ),
    );
  }
  getAnnouncementTitleViewTextTemplate(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-Bold',  fontSize: 18,
        decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
      ),
    );
  }
  getAnnouncementCommentFont(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-Medium',  fontSize: 12,
        decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.2,
      ),
    );
  }
  getAnnouncementCommentReplyFont(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-Bold',  fontSize: 18,
        decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
      ),
    );
  }
  getAnnouncementCommentUsernameFont(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-SemiBold',  fontSize: 13, decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
      ),
    );
  }
  getAnnouncementCommentTimeFont(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-SemiBold',  fontSize: 13, decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
      ),
    );
  }
  getGroupMemberFont(context,stringValue,fontSize){
    return Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
        fontFamily: 'Montserrat-Bold',  fontSize: 13, decoration: TextDecoration.none,
        color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
      ),
    );
  }
  getModalLabelFont(context,stringValue,fontSize){
    return fontSize==null? Text( stringValue, textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
          fontFamily: 'Montserrat-SemiBold',  fontSize: 13, decoration: TextDecoration.none,
          color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
        )
      ):  Text( stringValue, textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
      fontFamily: 'Montserrat-Bold',  fontSize: fontSize, decoration: TextDecoration.none,
      color: Color(0xff000000),letterSpacing: 0.0, height:1.0, fontWeight: FontWeight.bold,
      ),
    );
  }

  Decoration appMapDecoration=BoxDecoration(
    borderRadius: BorderRadius.circular(10),boxShadow: [
      BoxShadow(
          color:Color(0xffF1F1F1), spreadRadius: 1.0, blurRadius: 0.6, offset: Offset(0, 0), // changes position of shadow
        ),],
    color:Color(0xffffffff),
  );

  //::::::  Alignment(-1.0,-1.0)
  Color mapLabelTextColor=Color(0xff404040);
  Color mapLabelIconColor=Color(0xfffcfcfc);
  Color mapLabelBackgroundColor=Color(0xfffcfcfc);
  Color mapLabelForegroundColor=Color(0xfffcfcfc);
  Color mapActionBackground=Color(0xffffffff);
  Color mapActionForeground=Color(0xff404040);
  Color appMenuTextColor=Color(0xfff1f1f1);
  Color appMenuIconColor=Color(0xff80ffdb);
  Color appBarIconsColor=Color(0xff000000);
  Color appBarTextColor=Color(0xff000000);
  Color appTextInputBorder=Color(0xffbdb2ff);
  Color appSearchInputBorderColor=Color(0xfffcfcfc);
  Color appTitleColor=Color(0xffffffff);
  //Color appYellow=Color(0xffFDFAF1);
  Color appYellow=Color(0xfffefefe);
  //Color beautifulColor=Color(0xffFDFAF1);
  Color beautifulColor=Color(0xffbdb2ff);
  Color mainColor =Color(0xff9bf6ff);
  Color appContentBackgroundColor=Color(0xffffffff);
  Color appBackgroundColor=Color(0xffffffff);
  Color selectedNavigationIconColor=Color(0xff000000);
  Color unselectedNavigationIconColor=Color(0xffbbbbbb);
  Color selectedNavigationTextColor=Color(0xff1d3557);
  Color unselectedNavigationTextColor=Color(0xff404040);
  Color appLightTextLow=Color(0xffdddddd);
  Color textColor = Color(0xff);
  int calculateRatio(){
    return 0;
  }
  setAppScreenSize(double width,double height,param3){
    this.screenWidth=width;
    this.screenHeight=height;
  }
  getGroupTitleSize(){

  }
  getCommenterNameSize(){

  }
  getResponsiveFontSize(){

  }
  getUIWidth(request){
    return this.screenWidth;
  }
  getUIHeight(request){
    return this.screenHeight;
  }
  initUIParameters(double appWidth, double appHeight,param3,param4){
    this.screenWidth=appWidth;
    this.screenHeight=appHeight;

  }
}
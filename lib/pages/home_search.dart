import 'package:flutter/material.dart';
import 'main_banner.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'screen_image_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bruno/bruno.dart';
import '../helperLibraries/uiHelper.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';

class HomeSearch extends StatefulWidget{
  @override
  HomeSearchState createState()=>HomeSearchState();
}
class HomeSearchState extends State<HomeSearch>{
  final int _selectedIndex = 0;
  var user_id=['hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990','hio-18bdhsiiiis1990'];
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode=new FocusNode();

  var uiParametersInstance=new UIParameters();
  var searchKey=UniqueKey();
  var globalSearch=GlobalKey();
  void _sendDataToSecondScreen(BuildContext context,String username_,String user_photo_,String user_id_) {
    //----passing map data--------
    Map<String, dynamic> userData = {
      "username":username_,"user_photo":user_photo_,"user_id":user_id_
    };


    /*
    Navigator.pushNamed(context, message_Window.user_data,
        arguments: user_data);

     */

  }

  getSearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0,20,0,10),
      child:  ClipRRect(
        borderRadius:BorderRadius.circular(16.0),
        child: InkWell(
          onTap: (){
            Navigator.push( context, MaterialPageRoute(
              builder: (context) => new
              HomeSearch(),
            ));

          },
          child: Container(
            width: MediaQuery.of(context).size.width*44/100,
            color: Color(0xff30313b),
            height: 30,// width:  MediaQuery.of(context).size.width*40/100,//margin:EdgeInsets.all(14.0),
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment:  CrossAxisAlignment.end,
                    children: [

                      Container(
                        margin: EdgeInsets.fromLTRB(0.0,0,10,4),
                        child: Image.asset('assets/images/vueax-search-normal.png',fit:BoxFit.cover,width: 20.0,height: 20,),
                      )

                    ],
                  ),
                )
            ),
          ),
        ),

      ),
    );
  }


  @override
  Widget build(BuildContext context){
    uiParametersInstance.initUIParameters(MediaQuery.of( context).size.width, MediaQuery.of( context).size.height, 1, 1);

    FlutterStatusbarTextColor.setTextColor(FlutterStatusbarTextColor.light);


    return new SafeArea(
        top:false,bottom: false,

        child: Scaffold(
          backgroundColor: Color.fromRGBO(6,8,15,1),

          body: Container(

           color: Color.fromRGBO(6,8,15,1),
            child:SingleChildScrollView(



              child: ListView(
                shrinkWrap: true,
                children: [
                  getSearchBar(),
                ],
              )



            )






          ),
        )

      /*
      */


    )

    ;

    /*
    Scaffold(
      //Column is a vertical, linear layout.
      //backgroundColor:Colors.grey[100],
      //backgroundColor:Colors.lightBlueAccent,


      //the navigation bar is in bottom_navigation.dart..
      //bottomNavigationBar: new NavState(),//the navigation bar
    );

    */
  }
}
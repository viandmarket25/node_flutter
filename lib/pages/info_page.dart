import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../helperLibraries/uiHelper.dart';
//import '../market/productDesignChoice.dart';
import 'package:getwidget/getwidget.dart';

class InfoPage extends StatefulWidget{
  var productData;
  InfoPage({ Key key, @required this.productData}) : super(key: key);
  @override
  InfoPageState createState()=>InfoPageState(productData);
}
class InfoPageState extends State<InfoPage> {
  /// Roboto. Open Sans.  4. Lato.
  /// Oswald. 5. Poppins.
  var productImagePreview=[
    'assets/images/hood1.jpeg', 'assets/images/bag4.jpeg',
    'assets/images/hood2.jpeg','assets/images/hood3.jpeg','assets/images/hood4.jpeg',
    'assets/images/hood5.jpeg','assets/images/iphone1.jpeg','assets/images/shoe2.jpeg',
    'assets/images/shoe2.jpeg','assets/images/shoe3.jpeg','assets/images/shoe4.jpeg',
  ];

  bool _emojiBoxVisible=false;
  //bool _emoji_box_viaible=false;
  bool _addMoreBoxVisible=false;
  bool _addAudioBoxVisible=false;
  var _addEmojiBoxHeight=0;
  var _addMoreBoxHeight=0;
  var _addAudioMessageBoxHeight=0;
  var _chatBoxHeight= 78;
  //static final _chatBoxHeight=Container( height:MediaQuery.of(context).size.height );
  var _chatToolsBoxHeight=22;

  var productData;
   InfoPageState(this.productData);
  //-----------------
  final int _selectedIndex = 0;
  @override
  //var user_detail = pushedIn_value.split('_split_');

/*--------function to check who sent a message and render appropriate user interface ----------*/
  render_message_status(var value){
    if(value==1){
      return Padding(
        padding: EdgeInsets.fromLTRB(1, 0, 15, 27), child:Icon(
        FlutterIcons.check_circle_faw,size:18.0,color:Color.fromRGBO(85, 230, 193,1),
      ),
      );

    }else{
      return Container();
    }
  }

  var uiParametersInstance=new UIParameters();

  FocusNode _focusNode=new   FocusNode();
  TextEditingController _textFieldController=new  TextEditingController();
  @override

  void prepareTextField(){
    setState(() {
      _addMoreBoxVisible=false;
      _addAudioBoxVisible=false;
      _emojiBoxVisible=false;
      _chatBoxHeight=42;
    });
  }
  renderEmojiPicker(context){
    if(_emojiBoxVisible!=true){
      return Container();
    }else{
      setState(() {

      });
      return EmojiPicker(
        rows: 4,
        columns: 7,
        buttonMode: ButtonMode.MATERIAL,
        recommendKeywords: ["racing", "horse"],
        numRecommended: 10,
        onEmojiSelected: (emoji, category) {
          print(emoji);
        },

      );
      print("emoji avail");
    }
  }

  row_handle_render_mainAxis(var value){
    if(value==1){
      return  MainAxisAlignment.end;
    }else{return  MainAxisAlignment.start;}
  }
  row_handle_render_crossAxis(var value){
    if(value==1){
      return CrossAxisAlignment.end;
    }else{return CrossAxisAlignment.start;}
  }
  final List<String> imageList = [

  ];
  getProductImages(){
    imageList.clear();
    imageList.add(productData['product_photo']);
  }
  //who_Sender(is_Sender[i], message_count_[i])
  //-----------------
  @override
  Widget build(BuildContext context){
    getProductImages();
    FlutterStatusbarTextColor.setTextColor(FlutterStatusbarTextColor.light);
    uiParametersInstance.initUIParameters(MediaQuery.of( context).size.width, MediaQuery.of( context).size.height, 1, 1);
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*7/100,), // here the desired height
        child: AppBar(      backgroundColor: Color.fromRGBO(6,8,15,1),
          elevation: 0.0,  iconTheme:IconThemeData(
          color: Color(0xffffffff), size: 20.0,
        ),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row( //----row container for friend details, name and photo
                mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Container(
                    width:200,
                    child: Text( productData['username'],overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(textStyle:    TextStyle(
                      color: Color(0xffffffff), letterSpacing: 0.4, height:1.3,
                      fontSize: 15,fontWeight:FontWeight.w600,
                      decoration: TextDecoration.none,
                    ), ),
                  ),),
                ],
              ),
              Row(      //----row container for chat options, calls, and actions
                mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child:InkWell(
                          onTap: (){
                            //gotoCart();
                          },
                          child: Image.asset('assets/images/vueax-shopping-cart.png',fit:BoxFit.contain,width: 20,height:20,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // ...
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /***
                  Product photo
               ***/
              Container(
                color: Color.fromRGBO(6,8,15,1),
                height:   MediaQuery.of( context).size.height*70/100,
                child:SingleChildScrollView(
                  child: Container(
                 //   color: uiParametersInstance.appBackgroundColor,
                    height:  MediaQuery.of(context).size.height*75/100,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            height:460.0, //color:Colors.white,
                            width: MediaQuery.of(context).size.width*100/100,
                            child: GFCarousel(
                              hasPagination: true,  viewportFraction: 1.0,reverse: false,
                              height: 460.0,
                              passiveIndicator: Color(0xff5b5c5f),
                              activeIndicator: Color(0xffc55fff),
                              pagerSize: 12.0,
                              items: imageList.map(
                                    (url) {
                                  return Container(
                                    height:320.0,
                                    width: MediaQuery.of(context).size.width*100/100,

                                    // margin: EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                      child: Image.network(
                                        url, height:460.0, //color:Colors.white,
                                        width: MediaQuery.of(context).size.width*100/100,
                                        fit: BoxFit.cover,
                                        //width: MediaQuery.of(context).size.width*100/100,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              onPageChanged: (index) {
                                setState(() {
                                  index;
                                });
                              },
                            ),



                            //Image.asset(productData['product_photo'],fit:BoxFit.contain,),






                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            height:40.0, //color:uiParametersInstance.appYellow,

                            width: MediaQuery.of(context).size.width*100/100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*90/100,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child:  Text( productData['username'],overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.lato(textStyle:    TextStyle(
                                      color: Color(0xffffffff),letterSpacing: 0.2, height:1.0,
                                      fontSize: 16,fontWeight:FontWeight.w800,
                                      decoration: TextDecoration.none,
                                    ), ),
                                  ),

                                ),

                              ],
                            ),
                          ),
                          /***
                           * Price and like button
                           * **/
                          Container(
                            height:40.0,
                           // color: uiParametersInstance.appBackgroundColor,
                            // color:Colors.white,

                            width: MediaQuery.of(context).size.width*100/100,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width:100.0,
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  //height:340.0,color:Colors.white, width: MediaQuery.of(context).size.width*100/100,

                                  child: Text(  productData['product_price'],overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                      fontFamily: 'Montserrat-Bold',  fontSize: 22, decoration: TextDecoration.none,
                                      color:  Color(0xffffffff),letterSpacing: 0.0, height:0.8,// fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  /*
                                  Text( '₦'+ productData['product_price'],
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.alata(textStyle:    TextStyle(
                                      color: Color(0xff404040),letterSpacing: 0.2, height:1.0,
                                      fontSize: 22,fontWeight:FontWeight.w800,
                                      decoration: TextDecoration.none,
                                    ), ),
                                  ),


                                   */
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100.0,height:40.0,alignment: Alignment.centerRight,
                                      margin: EdgeInsets.fromLTRB(5.0,0,0,5),
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: IconButton(
                                        icon: Icon(
                                          EvaIcons.messageCircleOutline,size:24.0,color: Colors.black54,
                                        ),
                                        onPressed: ( ){

                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 40.0,alignment: Alignment.centerRight,
                                      margin: EdgeInsets.fromLTRB(0.0,0,20,10),
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: IconButton(
                                        icon: Icon(
                                          EvaIcons.heartOutline,size:24.0,color: Colors.black54,
                                        ),
                                        onPressed: ( ){

                                        },
                                      ),
                                    )

                                  ],
                                ),

                              ],
                            ),
                          ),
                          /***
                           * Product types (color, branding etc )
                           * **/
                          //productDesignChoice(),

                        ],
                      ),

                    ),
                  ),

                ),
              ),
              /**
               * Action Buttons, (add to cart and buy now)
               * ***/
              Container(
                height:170.0, //color:Colors.grey[100],
                decoration: BoxDecoration(
                  color: Color.fromRGBO(6,8,15,1),
                  border: Border(
                    top: BorderSide( //color: Colors.grey[200],
                        width: 1, style: BorderStyle.solid),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                //height:  MediaQuery.of(context).size.height*30/100,
                child:Column(
                  children: [
                    /***
                     * row for the product quantity handler
                     * **/
                    Container(
                      height:60.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child:
                                Text( 'Total',overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontFamily: 'Montserrat-Bold',  fontSize: 16, decoration: TextDecoration.none,
                                    color:  Color(0xffffffff), letterSpacing: 0.0, height:0.8,// fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child:
                                Text( productData['product_price'],overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontFamily: 'Montserrat-Bold',  fontSize: 16, decoration: TextDecoration.none,
                                    color:  Color(0xffffffff), letterSpacing: 0.0, height:0.8,// fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ),
                            ],
                          ),

                          Container(
                            //width:100.0,
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            margin: EdgeInsets.fromLTRB(0.0,0,20,0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  //height:60.0,
                                  padding: EdgeInsets.fromLTRB(0,10, 0, 0),
                                  child: Text('Quantity',overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                      fontFamily: 'Montserrat-Bold',  fontSize: 12, decoration: TextDecoration.none,
                                      color: Color(0xff000000), letterSpacing: 0.0, height:0.8,// fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    width:30.0,height:30.0, // color: Colors.white70,
                                    child:TextButton(
                                      child:  Text( '-', textAlign: TextAlign.center,
                                        style: GoogleFonts.alata(textStyle:    TextStyle(
                                          color: Color(0xff404040),letterSpacing: 0.0, height:0.8,
                                          fontSize: 28,fontWeight:FontWeight.w800, decoration: TextDecoration.none,
                                        ), ),
                                      ),
                                      onPressed:(){

                                      },
                                      //style: friendStyle,
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    width:60.0,height:30.0, // color: Colors.white,
                                    child:TextButton(
                                      //splashColor: Colors.red,
                                      //highlightColor: Colors.transparent,
                                      child:  Text( ' 2 ', textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(textStyle:    TextStyle(
                                          color: Color(0xff404040), letterSpacing: 0.0, height:0.8,
                                          fontSize: 16,fontWeight:FontWeight.w800, decoration: TextDecoration.none,
                                        ), ),
                                      ),
                                      onPressed:(){

                                      },
                                      //style: friendStyle,
                                    ),
                                  ),
                                ),


                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    width:30.0,height:30.0, // color: Colors.white70,
                                    child:TextButton(
                                      // splashColor: Colors.red,
                                      // highlightColor: Colors.transparent,
                                      child:  Text( '+', textAlign: TextAlign.center,
                                        style: GoogleFonts.alata(textStyle:    TextStyle(
                                          color: Color(0xff404040),letterSpacing: 0.0, height:0.8,
                                          fontSize: 28,fontWeight:FontWeight.w800, decoration: TextDecoration.none,
                                        ), ),
                                      ),
                                      onPressed:(){

                                      },
                                      //style: friendStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),

                    /***
                     * row for the product action button (purchase actions)
                     * **/

                    Container(
                      height:50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10.0,0,15,10),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child:InkWell(
                                    onTap:(){
                                      /*
                                      Navigator.push( context, MaterialPageRoute(
                                        builder: (context) => new
                                        //ScreenProductShop(),
                                      ));
                                       */
                                    },
                                    child: Image.asset('assets/images/vueax-shop.png',fit:BoxFit.contain,width: 20,height:20,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10.0,0,15,10),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child:InkWell(
                                    onTap:(){
                                     // openMessageWindow(context, "username_", "assets/images/nav-mod-user-account.png", "user_id_", 1, 1);

                                    },
                                    child: Image.asset('assets/images/vueax-message.png',fit:BoxFit.contain,width: 20,height:20,),
                                  ),),
                              ],
                            ),
                          ),
                          Container(
                            width: 10,
                            margin: EdgeInsets.fromLTRB(10.0,0,1,10),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                              ],
                            ),
                          ),
                          Container(
                            height:40.0,width:120.0, //color:Colors.red,
                            margin: EdgeInsets.fromLTRB(0.0,0,10,5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ), //here
                              //BorderRadius.all(Radius.circular(10)), //here
                             // color:Color(0xff303030),
                            ),
                            child: TextButton(
                              child:  Text('Buy Now',overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                  fontFamily: 'Montserrat-Bold',  fontSize: 14, decoration: TextDecoration.none,
                                  color:  Color(0xffffffff), letterSpacing: 0.0, height:0.8,// fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed:(){
                                /*
                                Navigator.push( context, MaterialPageRoute(
                                  builder: (context) => new
                                  ScreenCheckout(),
                                ));

                                 */

                              },
                              //style: friendStyle,
                            ),
                          ),


                          Container(
                            height:40.0,width:130.0, //color:Colors.grey,
                            //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            margin: EdgeInsets.fromLTRB(0.0,0,0,5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ), //here
                              //BorderRadius.all(Radius.circular(10)), //here
                              color:Color(0xff000000),
                            ),
                            child: TextButton(
                              //splashColor: Colors.transparent,
                              //highlightColor: Colors.transparent,
                              child: Text('Add to Cart',overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                  fontFamily: 'Montserrat-Bold',  fontSize: 14, decoration: TextDecoration.none,
                                  color:  Color(0xffffffff),
                                  letterSpacing: 0.0, height:0.8,// fontWeight: FontWeight.bold,
                                ),
                              ),
                              /*
                              Text( 'Add to Cart',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.alata(textStyle:    TextStyle(
                                  color: Color(0xffffffff),letterSpacing: 0.0, height:0.8,
                                  fontSize: 16,fontWeight:FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ), ),
                              ),
                               */

                              onPressed:(){

                              },
                              //style: friendStyle,
                            ),


                          ),
                        ],
                      ),

                    ),

                  ],
                ),


              ),
            ],

          ),
        ),
      ),
    );
  }




}
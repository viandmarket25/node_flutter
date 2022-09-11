import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../helperLibraries/uiHelper.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:bruno/bruno.dart';
import 'home_search.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'info_page.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
// ::::::::::: empty app bar
class provisionData extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
class ScreenAppHome extends StatefulWidget {
  //const CartScreen({Key? key}) : super(key: key);
  @override
  State<ScreenAppHome> createState() => ScreenAppHomeState();
}

class ScreenAppHomeState extends State<ScreenAppHome>with TickerProviderStateMixin {
  var uiParametersInstance=new UIParameters();
  bool checkBoxValue = false;
  get tabController => null;
  getBanners(){
    List media=['assets/images/banner.png','assets/images/banner.png',
      'assets/images/banner.png','assets/images/banner.png',
      'assets/images/banner.png'
    ];
    List<Container> banners=[];
    for(int i=0; i<media.length; i++){
      Container banner=Container(
          child:ClipRRect(
            borderRadius:BorderRadius.circular(0.0),
            child: Image.asset(media[i],fit:BoxFit.cover,width: double.infinity,
            ),
          )
      );
      banners.add(banner);
    }
    return banners;
  }
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode=new FocusNode();
  var searchKey=UniqueKey();
  var globalSearch=GlobalKey();
  var fetchedBackendData=false;
  List medalList=[];
  // ::::::::::  http request
  Future getProducts()async{
    if(fetchedBackendData==false){
      print("web request");
      final Uri productsURL= Uri.https(
          'service-krq6zihz-1313672865.sh.apigw.tencentcs.com',
          '/release/products');
      print(productsURL);
      var response= await http.get(
          productsURL
      );
      try {
        //------populate hive contacts
        print('Response status:'+response.statusCode.toString());
        //print(response.body);
        var resultData=jsonDecode(response.body);
        medalList=[];
        //
        for(int i=0; i< resultData.length; i++){
          print(i);
          print( resultData[i]['isSoldOut'].toString());
          print( resultData[i]['price'].toString());
          print(resultData[i]['priceOff'].toString());
          print(resultData[i]['title'].toString());
          print(resultData[i]['photo'].toString());
          print(resultData[i]['info'].toString());
          // var ph=http.read(url)
          Map<String, dynamic> d = {
            "isSoldOut":resultData[i]['isSoldOut'].toString(),
            "price":'¥'+resultData[i]['price'].toString(),
            "priceOff":resultData[i]['priceOff'].toString(),
            "title":resultData[i]['title'].toString(),
            "photo": resultData[i]['photo'].toString(),
            "info":resultData[i]['info'].toString(),
          };
           medalList.add(d);
        }
        //
       // print(resultData);
      }catch(SocketException){} finally {
        fetchedBackendData=true;
       // client.close();
      }
      fetchedBackendData=true;
    }
  }

  gotoProductDetails(BuildContext context,String username_,String product_photo_,String product_price_){
    Map<String, dynamic> productData = {
      "username":username_,"product_photo":product_photo_,"product_price":product_price_
    };
    print(productData);
    Navigator.push( context, MaterialPageRoute(
      builder: (context) => new
      InfoPage( productData: productData, key: UniqueKey(),

      ),
    ));
  }
  getSearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0,0,10,0),
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
                    child: Image.asset('assets/images/vueax-search-normal.png',fit:BoxFit.cover,width: 20.0,height: 20,),)

                ],
              ),
            )
          ),
        ),
      ),

        ),
    );
  }
  List<BadgeTab> tabs = [];
  //TabController tabController=new TabController(length: 2, vsync: vsync);
  getSearchBarEditable(){
    return Container(
      width:100, height:40,
      child: BrnSearchAppbar(
      brightness: Brightness.light,
      showDivider: true,
      //自定义的leading显示
      leading: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          key:searchKey,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image.asset(
                'assets/image/icon_triangle.png',
                color: Colors.grey,
                scale: 3.0,
                height: 7,
                width: 7,
              ),
            )
          ],
        ),
      ),
      //点击 leading的回调
      leadClickCallback: (controller, update) {
        //controller 是文本控制器，通过controller 可以拿到输入的内容 以及 对输入的内容更改
        //update 是setState方法的方法命，update() 就可以刷新输入框
        BrnPopupListWindow.showPopListWindow(context, globalSearch, data: ["aaaa", "bbbbb"], offset: 10);
      },
      //输入框 文本内容变化的监听
      searchBarInputChangeCallback: (input) {
        BrnToast.show(input, context);
      },
      //输入框 键盘确定的监听
      searchBarInputSubmitCallback: (input) {
        BrnToast.show(input, context);
      },
      //为输入框添加 文本控制器，如果不传则使用默认的
      controller:searchController,
      //为输入框添加 焦点控制器，如果不传则使用默认的
      focusNode: searchFocusNode,
      //右侧取消action的点击回调
      //参数同leadClickCallback 一样
      dismissClickCallback: (controller, update) {
        Navigator.of(context).pop();
      },
    ),);
  }

  getMedals(){
    print("medal list:: "+medalList.length.toString());
    List<Container> medals=[];
    for(int i=0; i<medalList.length; i++){
      double add_=i.toDouble()+1;
      medalHeight=add_.toDouble()*460.0;
      Container medal=Container(
        height: 420,  margin: EdgeInsets.fromLTRB(0, 4, 0, 34),
        child: ClipRRect(
            borderRadius:BorderRadius.circular(12.0),
            child:InkWell(
            onTap:(){
              gotoProductDetails( context,medalList[i]['title'],medalList[i]['photo'],medalList[i]['price']);
            },

            child: Container(
              width: MediaQuery.of(context).size.width*100/100,
              color:  Color(0xff24252a),
              child:  Container(
               // height: 40,
                width: MediaQuery.of(context).size.width*100/100,
                //color:  Color.fromRGBO(0,8,20,0.2),
                child: Column(
                  children: [
                    // :::::::: photo area
                    Container(
                      height: 320,
                      width: MediaQuery.of(context).size.width*100/100,
                      //color:  Color.fromRGBO(0,8,20,0.2),
                      child: Stack(
                        children: [
                          Positioned(
                              child:  Container(
                                height: 320, width: MediaQuery.of(context).size.width*100/100,
                               // color:  Color.fromRGBO(0,8,20,0.2),
                                child: ClipRRect(
                                          borderRadius:BorderRadius.circular(16.0),
                                  child: Image.network(medalList[i]['photo'],fit:BoxFit.cover,width: MediaQuery.of(context).size.width*100/100,

                                  ),
                                )

                              ),
                          ),
                          Positioned(
                            top:0,
                            child: Container(
                             // height: 320,
                              width: MediaQuery.of(context).size.width*100/100,
                              //color:  Color.fromRGBO(0,8,20,0.2),
                              child: Container(
                                child:
                                Container(
                                  margin: EdgeInsets.fromLTRB(14.0,12,0,0),
                                  height: 20, //width:  MediaQuery.of(context).size.width*40/100,//margin:EdgeInsets.all(14.0),
                                  child: Row(
                                    children: [
                                      medalList[i]['isSoldOut']!=true? BrnTagCustom(
                                        tagText: '己售罄',
                                        backgroundColor: Color(0xffe713f3),
                                        tagBorderRadius: BorderRadius.circular(4.8),
                                        //textPadding: EdgeInsets.only(bottom: 0.5, left: 8, right: 8, top: 1.5),
                                        fontSize: 14,
                                      ):Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ::::::::: text area
                    Container(
                      height: 100,
                    //  width: MediaQuery.of(context).size.width*100/100,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:  CrossAxisAlignment.start,
                       children: [
                         // :::: left text
                         Container(
                         //  height: 80,
                          width: MediaQuery.of(context).size.width*50/100-20,
                           child: Column(
                             children: [
                               Container(
                                 margin: EdgeInsets.fromLTRB(14.0,10,0,0),
                                 height: 20, width:  MediaQuery.of(context).size.width*40/100,//margin:EdgeInsets.all(14.0),
                                 child: Padding(
                                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                   child:Text(medalList[i]['title'],overflow: TextOverflow.ellipsis,
                                       textAlign: TextAlign.left,
                                       style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                         fontFamily: 'Montserrat-Bold',  fontSize: 20, decoration: TextDecoration.none,
                                         color: Color(0xffffffff),letterSpacing: 0.3, height:1.0,
                                       )
                                   ),
                                 ),
                               ),
                               Container(
                                 margin: EdgeInsets.fromLTRB(14.0,8,0,14),
                                 height: 20, //width: 80,//margin:EdgeInsets.all(14.0),
                                 child: Row(
                                   children: [
                                     BrnTagCustom(
                                       tagText:'限量',
                                       backgroundColor: Color(0xffe359ff),
                                       textColor: Color(0xff202020),
                                       fontWeight: FontWeight.bold,
                                       //tagBorderRadius: BorderRadius.circular(3.8),
                                       tagBorderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5)  ),

                                       textPadding: EdgeInsets.only(bottom: 0.5, left: 8, right: 8, top: 0),
                                       fontSize: 14,
                                     ),
                                     BrnTagCustom(
                                       tagText:'100份',
                                       backgroundColor: Color(0xff5b5c5f),
                                       textColor: Color(0xffc55fff),
                                       fontWeight: FontWeight.bold,

                                       //tagBorderRadius: BorderRadius.circular(3.8),
                                       tagBorderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5)  ),

                                       textPadding: EdgeInsets.only(bottom: 0.5, left: 8, right: 14, top: 0),
                                       fontSize: 14,
                                     )
                                   ],
                                 ),
                               ),

                               Container(
                                 margin: EdgeInsets.fromLTRB(14.0,0,0,0),
                                 height: 20, width: MediaQuery.of(context).size.width*40/100,//margin:EdgeInsets.all(14.0),
                                 child: Padding(
                                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                   child:Text(medalList[i]['info'],overflow: TextOverflow.ellipsis,
                                       textAlign: TextAlign.left,
                                       style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                         fontFamily: 'Montserrat-Medium',  fontSize: 14, decoration: TextDecoration.none,
                                         color: Color(0xffffffff),letterSpacing: 0.3, height:1.0,
                                       )
                                   ),
                                 ),
                               ),


                             ],
                           ),
                           // color:  Color.fromRGBO(0,8,20,0.2),

                         ),
                         // :::::::: right text
                         Container(
                           height: 80,
                            width: MediaQuery.of(context).size.width*50/100-20,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.end,
                             children: [
                               Container(
                                 margin: EdgeInsets.fromLTRB(0.0,18,30,0),
                                 height: 20,// width:  MediaQuery.of(context).size.width*40/100,//margin:EdgeInsets.all(14.0),
                                 child: Padding(
                                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                   child:Text(medalList[i]['price'],overflow: TextOverflow.ellipsis,
                                       textAlign: TextAlign.left,
                                       style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                         fontFamily: 'Montserrat-SemiBold',  fontSize: 22, decoration: TextDecoration.none,
                                         color: Color(0xffffffff),letterSpacing: 0.3, height:1.0,
                                       )
                                   ),
                                 ),
                               ),

                             ],
                           ),
                           // color:  Color.fromRGBO(0,8,20,0.2),
                         ),
                       ],
                     ),
                     // color:  Color.fromRGBO(0,8,20,0.2),

                    ),
                  ],
                ),

              ),
            ),)
        ),
      );
      medals.add(medal);
    }
    pageLoaded=true;
    return medals;
  }
  bool pageLoaded=false;
  reloadProducts(){
    setState(() {
      _scrollToTop();
      fetchedBackendData=false;
      getProducts();
      print('reloading app...');
    });
  }

  var tabIndex=0;
  double medalHeight=0;
  goTab(state, index){
    tabIndex=index;
    //state.refreshBadgeState(index);
    /*
    setState(() {
      print('switched tab...');
      print(index);
    });
    */

  }

  // this variable determnines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;
  final controller = PageController();
   ScrollController _scrollController=new ScrollController();
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }
  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
  @override
  Widget build(BuildContext context) {
    fetchedBackendData==false? getProducts():false;
    /*
    pageLoaded==false? getProducts(context):false;
    pageLoaded=true;
     */
    FlutterStatusbarTextColor.setTextColor(FlutterStatusbarTextColor.light);
    return Stack(
      children: [
        Positioned(
           child: Scaffold(
             floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
             floatingActionButton: _showBackToTopButton == false ? null : FloatingActionButton(
              backgroundColor: Color(0xffab3dd7), elevation: 10,
               splashColor: Color(0xfff1f1f1),
               foregroundColor:Color(0xffffffff) ,
               enableFeedback: true,
               onPressed: _scrollToTop,
               child: const Icon(Icons.arrow_upward),
             ),
            backgroundColor: Color.fromRGBO(6,8,15,1),
            body: Container(
              child: SingleChildScrollView(
                controller: _scrollController,
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    Column(children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Container(

                                  ),
                                  Container(

                                  ),
                                ],
                              ),
                              //new HomeSearch(),
                            ),
                            // ::::::::::::::::: body
                            Container(
                              child: ListView(
                                // mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment:  CrossAxisAlignment.start,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Container(
                                    margin:EdgeInsets.all(14.0),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*100/100,
                                    color:  Color.fromRGBO(0,8,20,0.2),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:  CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                                            children: [
                                              Container( height:30.0, width:30.0, child:
                                              //Image.asset("assets/images/icons8-reading-menu.png",fit:BoxFit.contain,
                                              Image.asset('assets/images/flutter-logo.png',fit:BoxFit.contain,width: 20,height:20,),
                                              ),

                                              Container(
                                                margin: EdgeInsets.fromLTRB(4.0,2,0,0),
                                                height: 20,// width:  MediaQuery.of(context).size.width*40/100,//margin:EdgeInsets.all(14.0),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child:Text('幻物藏',overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                        fontFamily: 'Montserrat-SemiBold',  fontSize: 22, decoration: TextDecoration.none,
                                                        color: Color(0xffffffff),letterSpacing: 0.3, height:1.0,
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child:getSearchBar(),

                                        )

                                      ],
                                    ),

                                  ),
                                  Container(
                                    height: 140,   margin:EdgeInsets.all(14.0),
                                    child:Card(
                                        elevation: 0.0,
                                        color: Color(0xfffcfcfc),shadowColor:  Color(0xffdddddd),
                                        margin:EdgeInsets.all(0.0),shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                        child: ClipRRect(
                                          borderRadius:BorderRadius.circular(10.0),
                                          child:  GFCarousel(
                                            hasPagination: true,viewportFraction: 1.0,
                                            height: 140,passiveIndicator: Color(0xffcccccc) ,
                                            activeIndicator: Color(0xffe713f3),
                                            pagerSize: 10.0,
                                            items: getBanners(),
                                            onPageChanged: (index) {
                                              setState(() {
                                                //index;
                                              });
                                            },
                                          ),
                                        )

                                    ),
                                  ),
                                  Container(

                                    height: 40,
                                    width: MediaQuery.of(context).size.width*100/100,
                                    color:  Color(0xff15171d),
                                    child:  Container(
                                      margin: EdgeInsets.only(bottom: 0.5, left: 26, right: 8, top: 0),

                                      height: 40,
                                      width: MediaQuery.of(context).size.width*100/100,
                                      color:  Color.fromRGBO(0,8,20,0.2),
                                      child: Row(
                                        children: [
                                          BrnTagCustom(
                                            tagText:'限量',
                                            backgroundColor: Color(0xffe359ff),
                                            textColor: Color(0xff202020),
                                            fontWeight: FontWeight.bold,
                                            //tagBorderRadius: BorderRadius.circular(3.8),
                                            tagBorderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5)  ),
                                            textPadding: EdgeInsets.only(bottom: 0.5, left: 8, right: 8, top: 0),
                                            fontSize: 14,
                                          ),
                                          BrnTagCustom(
                                            tagText:'注册需实名认证才可购买心仪藏品',
                                            backgroundColor: Color(0xff212329),
                                            textColor: Color(0xff4c73fc),
                                            fontWeight: FontWeight.bold,
                                            //tagBorderRadius: BorderRadius.circular(3.8),
                                            tagBorderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5)  ),
                                            textPadding: EdgeInsets.only(bottom: 1.5, left: 8, right: 14, top: 1),
                                            fontSize: 12,
                                          )
                                        ],
                                      ),

                                    ),

                                  ),
                                  fetchedBackendData==false?Container(
                                    height: 120, width: MediaQuery.of(context).size.width*100/100,
                                    child:   Container(
                                      height: 20,width:20,
                                      margin:EdgeInsets.all(14.0),
                                      child:  Column(
                                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 20,width:20,
                                            // margin:EdgeInsets.all(14.0),
                                            child: CircularProgressIndicator(
                                              semanticsLabel: '',
                                              color: Colors.white,
                                              strokeWidth: 1.5,
                                            ),

                                          ),

                                        Container(
                                          //height:60.0,
                                          padding: EdgeInsets.fromLTRB(0,10, 0, 0),
                                          child: Text('Refreshing...',overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                              fontFamily: 'Montserrat-Bold',  fontSize: 12, decoration: TextDecoration.none,
                                              color: Color(0xffe713f3), letterSpacing: 0.0, height:0.8,// fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),


                                        ],
                                      ),
                                    ),
                                  ):Container(),
                                  Container(
                                    //margin:EdgeInsets.all(14.0),
                                    height: medalHeight+100,
                                    width: MediaQuery.of(context).size.width*100/100,
                                    color:  Color.fromRGBO(0,8,20,0.2),
                                    child:  DefaultTabController(
                                      length: 2,
                                      initialIndex: 0,
                                      child:
                                      Container(
                                        height: medalHeight+100,

                                        // padding: const EdgeInsets.symmetric(horizontal: 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment:  CrossAxisAlignment.start,
                                          children: <Widget>[

                                            // :::::::::::::::: tab bar
                                            fetchedBackendData?SizedBox(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width*100/100,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 180,  height: 40, //margin:EdgeInsets.all(14.0),
                                                    child: TabBar(
                                                      indicatorColor: Color(0xffdddddd), unselectedLabelColor: Color(0xff5978b3),
                                                      tabs:[
                                                        Tab(
                                                          height: 38, text: "官方发布",
                                                        ),
                                                        Tab(
                                                          height: 38, text: "发布日历",
                                                        ),
                                                      ],
                                                      labelColor: Color(0xffffffff), indicatorSize: TabBarIndicatorSize.label,
                                                      indicator: MaterialIndicator(
                                                        color:Color(0xffe713f3), strokeWidth: 2, height: 2,
                                                        topLeftRadius: 5, topRightRadius: 5,
                                                        bottomLeftRadius: 5, bottomRightRadius: 5,
                                                        tabPosition: TabPosition.bottom, horizontalPadding: 14,
                                                        //paintingStyle: PaintingStyle.fill
                                                      ),
                                                    ),
                                                  ),
                                                ],),
                                            ):Container(),

                                            // :::::::::::::::::: tab bar view
                                            fetchedBackendData? SizedBox(
                                              height: medalHeight,

                                              width: MediaQuery.of(context).size.width*100/100,
                                              child:
                                              TabBarView(
                                                // viewportFraction: 0.0,
                                                physics: NeverScrollableScrollPhysics(),
                                                children: [
                                                  // ::::::::: medal list
                                                  SizedBox(
                                                    height: medalHeight,
                                                    // height: double.infinity,
                                                    //height: fetchedBackendData? MediaQuery.of(context).size.height : 0,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.all(14.0),
                                                      physics: NeverScrollableScrollPhysics(),
                                                      // children:fetchedBackendData==true && pageLoaded==false ? getMedals():[],
                                                      children: getMedals(),
                                                    ),
                                                  ),

                                                  Container(
                                                      margin: EdgeInsets.fromLTRB(14.0,60,0,0),
                                                      //height: 40,
                                                      width: MediaQuery.of(context).size.width*100/100,
                                                     // color: Color.fromRGBO(0,8,20,0.2),
                                                      child: BrnTagCustom(
                                                        tagText:'Nodejs and Flutter Task',
                                                        backgroundColor: Color.fromRGBO(6,8,15,1),
                                                        textColor: Color(0xff4c73fc),
                                                        fontWeight: FontWeight.bold,
                                                        //tagBorderRadius: BorderRadius.circular(3.8),
                                                        tagBorderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5)  ),
                                                        textPadding: EdgeInsets.only(bottom: 1.5, left: 8, right: 14, top: 1),
                                                        fontSize: 12,
                                                      )
                                                  ),





                                                ],
                                              ),

                                            ):Container(),



                                          ],
                                        ),
                                      ),



                                    ),


                                  ),
                                  SizedBox(height: 30.0
                                  ),
                                  // This is our back-to-top button
                                  //
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],)
                  ]),
              ),
              ),
            ),
        ),
        // ::::::::::::::::: navigation

        Positioned(
          top: MediaQuery.of( context).size.height*92/100,
            child: Container(
              height:  MediaQuery.of( context).size.height*8/100,
              width: MediaQuery.of(context).size.width*100/100,
              color:  Color.fromRGBO(0,8,20,0.9),
              child:  Container(
                margin: EdgeInsets.fromLTRB(0.0,0,0,0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment:  CrossAxisAlignment.center,
                  children: [
                    InkWell(

                      splashColor: Color(0xffffffff),
                      onTap:(){
                        print('clicked 0 ');
                      },
                      child: Container(

                        child:Column(
                        children: [


                          Container(
                            margin: EdgeInsets.fromLTRB(0.0,6,0,0),

                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0,0,10,4),
                                  child: Image.asset('assets/images/nav-bar-1.png',fit:BoxFit.cover,width: 24.0,height: 24.0,),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0,0,10,4),
                                  child:Text('幻市',overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                        fontFamily: 'Montserrat-SemiBold',  fontSize: 14, decoration: TextDecoration.none,
                                        color: Color(0xff9944f9),letterSpacing: 0.3, height:1.0,
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),),
                    Container(
                      child:Column(
                        children: [
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height:50,width:50,
                                  margin: EdgeInsets.fromLTRB(0.0,0,10,4),

                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    InkWell(
                      onTap:(){
                        print('clicked 2 ');

                      },
                    child:Container(
                      child:Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0,6,0,0),

                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0,0,10,4),
                                  child: Image.asset('assets/images/nav-bar-2.png',fit:BoxFit.cover,width: 24.0,height: 24,),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0,0,10,4),
                                  child:Text('幻匣',overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                        fontFamily: 'Montserrat-SemiBold',  fontSize: 14, decoration: TextDecoration.none,
                                        color: Color(0xffffffff),letterSpacing: 0.3, height:1.0,
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),),
                  ],
                ),
              ),
            ),
        ),
        Positioned(
          top: MediaQuery.of( context).size.height*90/100,
          child: Container(
            height:  MediaQuery.of( context).size.height*8/100,
            width: MediaQuery.of(context).size.width*100/100,
            //color:  Color.fromRGBO(0,8,20,0.9),
            child:  Container(
              margin: EdgeInsets.fromLTRB(0.0,0,0,0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment:  CrossAxisAlignment.center,
                children: [

                Container(
                    child:Column(
                      children: [
                        Container(
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                            children: [
                            Container(
                                  height:50,width:50,
                                  margin: EdgeInsets.fromLTRB(0.0,0,10,4),
                                  child: ClipRRect(
                                    borderRadius:BorderRadius.circular(60.0),
                                    child:Material(child:
                                    InkWell(
                                      highlightColor:  Color.fromRGBO(171,61,215,1),
                                      splashColor: Color.fromRGBO(171,61,215,1),
                                      onTap:(){
                                        print('clicked 1 ');
                                        reloadProducts();
                                      },
                                   child: Container(
                                     //color:Colors.green,
                                      height:50,width:50, color:Color.fromRGBO(171,61,215,0.7),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/nav-bar-3.png',fit:BoxFit.cover,width: 30.0,height: 30.0,),
                                        ],),
                                    ),),),
                                  )
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
        ),
        /*
        Positioned(
          top: MediaQuery.of( context).size.height*90/100,
          child: Container(
            height:  MediaQuery.of( context).size.height*8/100,
            width: MediaQuery.of(context).size.width*100/100,
            //color:  Color.fromRGBO(0,8,20,0.9),
            child:  Container(
              margin: EdgeInsets.fromLTRB(0.0,0,0,0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment:  CrossAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Color(0xffffffff),
                    onTap:(){
                      print('clicked 1 ');
                      reloadProducts();
                    },
                    child:Container(
                      child:Column(
                        children: [
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height:50,width:50,
                                    margin: EdgeInsets.fromLTRB(0.0,0,10,4),
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(60.0),
                                      child: Container(
                                        height:50,width:50, color:Color(0xffab3dd7),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment:  CrossAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/images/nav-bar-3.png',fit:BoxFit.cover,width: 30.0,height: 30.0,),
                                          ],),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),),
                ],
              ),
            ),
          ),
        ),

        */
      ],
    );
  }
}
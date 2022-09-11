import 'package:flutter/material.dart';
class ScreenImageSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          iconTheme:IconThemeData(
            color: Colors.black87,
          ),titleSpacing:0.0,
          title:Container(
            margin:EdgeInsets.symmetric(
                horizontal:4.0, vertical:10.0),
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),

          ),
          //backgroundColor: Color.fromARGB(255, 102, 204, 255),
          backgroundColor:Colors. grey[50],
          elevation: 0.0,
          bottomOpacity: 0.4,
        ),
        body:Center(
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),

                ),
              ),
              elevation: 0.0,
              child: Container(
                height: 605.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius:BorderRadius.circular(10.0),

                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );

  }


}
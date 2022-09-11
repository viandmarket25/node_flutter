import 'package:flutter/material.dart';
class MainBanner extends StatelessWidget{
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return (
          Card(
            color: Colors.grey[100],
            margin: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
            ),
          ),
          elevation: 0.0,
            child: Container(
            height: 95.0,
              child: Row(
                children: <Widget>[
                 Expanded(
                   child: ClipRRect(
                        borderRadius:BorderRadius.circular(10.0),
                      child: Image.asset('assets/images/9.jpg',fit: BoxFit.fill,


                    )
                    ),
                  ),

                ],
              ),
            ),
          )
    );
  }
}
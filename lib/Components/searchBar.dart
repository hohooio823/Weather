import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchBar extends StatefulWidget {
  Function(dynamic) callback;
  SearchBar(this.callback);

  @override
  _SearchBarState createState() => _SearchBarState();
}
class _SearchBarState extends State<SearchBar> {
  var city='';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height:150,
      alignment: Alignment.center,
      child:Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child:Container(
          height:40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [BoxShadow(
              offset:Offset(0,10),
              blurRadius: 50,
            )]
              ),
              child:TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration : InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16,0,16,6),
                        suffixIcon: Icon(CupertinoIcons.search,size:20,color: Colors.blueGrey,),
                        hintText: 'Enter your city name'
                      ),
                      cursorColor: Colors.grey,
                      onChanged: (text)=>{
                        if(text!=''){
                          widget.callback(text)
                        }
                      },
                    )
            )
      )
    );
  }
}


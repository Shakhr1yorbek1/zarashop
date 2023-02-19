import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {

  static Future<bool> commanDialog(context ,content,title ,yes , no , isSingle) async {
    return await showDialog(
        context: context,
        builder: (context){
          return Platform.isAndroid ? AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context, false);
                },
                child: Text(no),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context, true);
                },
                child: Text(yes,style: const TextStyle(color: Colors.red),),
              ),
            ],
          ) : CupertinoAlertDialog(
            title:Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context, false);
                },
                child: Text(no),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context, true);
                },
                child: Text(yes,style: const TextStyle(color: Colors.red),),
              ),
            ],
          );
        }
    );
  }


}
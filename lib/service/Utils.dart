import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Utils {
  static Future<bool> commanDialog(
      context, content, title, yes, no, isSingle) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Platform.isAndroid
              ? AlertDialog(
                  title: Text(title),
                  content: Text(content),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(no),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        yes,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              : CupertinoAlertDialog(
                  title: Text(title),
                  content: Text(content),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(no),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        yes,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
        });
  }

  static fToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade400,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}

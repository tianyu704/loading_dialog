import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:loading_dialog/loading_dialog.dart';

void main() {
  BuildContext context = null;
  LoadingDialog loadingDialog = LoadingDialog(
    buildContext: context,
    loadingView: null, //yourself loading view ,default is CircularProgressIndicator
    radius: 15, //dialog bg radius
    elevation: 0, //dialog elevation
    size: 50, // loading view size
    padding: 10, //text to loading view
    width: 150, //dialog width
    height: 150, //dialog height
    loadingMessage: "Loading...", //your message
    textColor: Colors.black54, //message text color
    textSize: 14,//message text size
    style: LoadingDialogStyle.horizontal, // or vertical
    backgroundColor: Colors.white, //dialog background color
    barrierColor: Colors.black54, //window color
    barrierDismissible: true, //touch window dismiss
  );
}

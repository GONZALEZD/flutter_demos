import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DevelopmentIntent extends Intent {
  final VoidCallback action;

  DevelopmentIntent({this.action});
}

class DevelopmentAction extends Action<DevelopmentIntent> {
  @override
  Object invoke(covariant DevelopmentIntent intent) {
    if (kDebugMode) {
      intent.action?.call();
    }
  }
}

class SendDebugDataIntent extends Intent {
  const SendDebugDataIntent();
}

class SendDebugDataAction extends ContextAction {
  @override
  Object invoke(covariant Intent intent, [BuildContext context]) {
    if (!kDebugMode) {
      return null;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Send debug big data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration:
                  InputDecoration(hintText: 'email_address@gmail.com'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                      'An archive of data will be sent by email, and contains following things:'
                          '\n - log of http requests and responses'
                          '\n - information about user actions'
                          '\n - internal database'
                          '\n - Video file played (if any)'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Send Report', style: TextStyle(color: Colors.white),),
              ),
            ],
          );
        });
  }
}

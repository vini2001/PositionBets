import 'package:flutter/material.dart';

class MyAlert{
  static void alert(BuildContext context, String title, String message, {String btnNeg = "Não", btnPos, Function clickYes,  Function clickNo}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: btnPos != null
              ? (btnNeg != null
              ? <Widget>[
            new Theme(
                data: ThemeData(accentColor: Color(0xff333333)),
                child: new FlatButton(
                  child: new Text(btnNeg),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    if (clickNo != null) {
                      clickNo();
                    }
                  },
                )),
            new Theme(
                data: ThemeData(accentColor: Color(0xff333333)),
                child: new FlatButton(
                  child: new Text(btnPos),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    if (clickYes != null) {
                      clickYes();
                    }
                  },
                )),
          ]
              : <Widget>[
            new Theme(
                data: ThemeData(accentColor: Color(0xff333333)),
                child: new FlatButton(
                  child: new Text(btnPos),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    if (clickYes != null) {
                      clickYes();
                    }
                  },
                )),
          ])
              : <Widget>[
            new Theme(
                data: ThemeData(accentColor: Color(0xff333333)),
                child: new FlatButton(
                  child: new Text("OK"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    if (clickYes != null) {
                      clickYes();
                    }
                  },
                )),
          ],
        );
      },
    );
  }

  static void alertNotDismissable(BuildContext context, String title, String message, {String btnNeg = "Não", btnPos, Function clickYes,  Function clickNo}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          child: AlertDialog(
            title: new Text(title),
            content: new Text(message),
            actions: btnPos != null
                ? (btnNeg != null
                ? <Widget>[
              new Theme(
                  data: ThemeData(accentColor: Color(0xff333333)),
                  child: new FlatButton(
                    child: new Text(btnNeg),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (clickNo != null) {
                        clickNo();
                      }
                    },
                  )),
              new Theme(
                  data: ThemeData(accentColor: Color(0xff333333)),
                  child: new FlatButton(
                    child: new Text(btnPos),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (clickYes != null) {
                        clickYes();
                      }
                    },
                  )),
            ]
                : <Widget>[
              new Theme(
                  data: ThemeData(accentColor: Color(0xff333333)),
                  child: new FlatButton(
                    child: new Text(btnPos),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (clickYes != null) {
                        clickYes();
                      }
                    },
                  )),
            ])
                : <Widget>[
              new Theme(
                  data: ThemeData(accentColor: Color(0xff333333)),
                  child: new FlatButton(
                    child: new Text("OK"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (clickYes != null) {
                        clickYes();
                      }
                    },
                  )),
            ],
          ), onWillPop: () {},
        );
      },
    );
  }

  static void alertProgress(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            child: SimpleDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ),
            onWillPop: () {},
          );
        });
  }

}
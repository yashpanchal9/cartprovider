import 'package:flutter/material.dart';

class CommonWidget {
  Future<void> neterrorDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'E-commerce ',
                          ),
                          const Padding(padding: EdgeInsets.all(15)),
                          const Text(
                            "Please connect to Internet!!",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(20)),
                          SizedBox(
                              width: 120,
                              height: 40,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: "Medium",
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }))
                        ]));
              }));
        });
  }
}

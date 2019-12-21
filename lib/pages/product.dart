import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mx_crud/ui_elements/title_defualt_widget.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageURL;
  ProductPage({this.title, this.imageURL});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Image.asset(imageURL),
            TitleDefualtWidget(
              title: title,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Details'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('are you sure'),
                            content: Text('this action cant be undone'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('CANCEL'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              FlatButton(
                                child: Text('DELETE'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context, true);
                                },
                              )
                            ],
                          );
                        });
                  }),
            )
          ],
        )),
      ),
    );
  }
}

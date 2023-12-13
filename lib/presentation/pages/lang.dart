import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.language),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Select Language'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  context.setLocale(Locale('en'));
                  Navigator.pop(context);
                },
                child: Text('English'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  context.setLocale(Locale('ru'));
                  Navigator.pop(context);
                },
                child: Text('Russian'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  context.setLocale(Locale('kk'));
                  Navigator.pop(context);
                },
                child: Text('Kazakh'),
              ),
            ],
          ),
        );
      },
    );
  }
}
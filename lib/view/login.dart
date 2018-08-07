import 'package:flutter/material.dart';

// 登录
class Login extends StatelessWidget {
  String title;

  Login({title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.red[700],
        backgroundColor: Colors.white,
      ),
      home: Scaffold(
//        appBar: AppBar(
//          title: Text('网易云音乐'),
//        ),
        body: Container(
//        margin: EdgeInsets.fromLTRB(12.0, 96.0, 12.0, 12.0),
          padding: EdgeInsets.fromLTRB(12.0, 96.0, 12.0, 12.0),
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.red[500])),
            color: Colors.white,
          ),
          child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'http://p3.music.126.net/tBTNafgjNnTL1KlZMt7lVA==/18885211718935735.jpg',
                width: 96.0,
                height: 96.0,
              ),
              OutlineButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/mobilePhoneLogin');
                },
                child: Text(
                  '手机号登录',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                borderSide:
                    new BorderSide(color: Theme.of(context).primaryColor),
              ),
              OutlineButton(
                onPressed: null,
                child: Text(
                  '注册',
                  style: TextStyle(color: Colors.red),
                ),
                textTheme: ButtonTextTheme.primary,
              ),
              GestureDetector(
                child: Text(
                  '游客登录',
                  style: TextStyle(color: Colors.grey[500], fontSize: 10.0),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/index');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

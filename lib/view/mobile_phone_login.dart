import 'package:flutter/material.dart';

class MobilePhoneLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.red[700],
        backgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text('手机号登录'),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.phone_iphone)),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(icon: Icon(Icons.lock_outline)),
              ),
              OutlineButton(
                onPressed: () {



                  Navigator.of(context).pushNamed('/index');
                },
                child: Text('登录'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/view/djradio_page.dart';
import 'package:netease_cloud_music/view/event_page.dart';
import 'package:netease_cloud_music/view/login.dart';
import 'package:netease_cloud_music/view/mobile_phone_login.dart';

void main() => runApp(MyApp());

const title = '网易云音乐';
const slogan = '网易云音乐，听见好时光';

const tabs = [
  {'title': '推荐'},
  {'title': '朋友'},
  {'title': '电台'}
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.red[700],
        backgroundColor: Colors.white,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => Login(title: '登录'),
        '/index': (BuildContext context) => MyApp(),
        '/mobilePhoneLogin': (BuildContext context) => MobilePhoneLogin(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: Center(child: const Text(title)),
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  }),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {})
              ],
              bottom: TabBar(
                isScrollable: false,
                tabs: tabs.map((Map item) {
                  return Tab(text: item['title']);
                }).toList(),
              ),
            ),
            body: TabBarView(
              children: [Recommend(), EventPage(), DjRadioPage()],
            )));
  }
}

class Recommend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendState();
  }
}

class RecommendState extends State<Recommend>
    with AutomaticKeepAliveClientMixin {
  var list = [];

  _list() async {
    Dio dio = new Dio();
    Response response = await dio.post("https://music.163.com/eapi/batch",
        data: {
          'params':
              '0BD8BB39A78692F1744DEFF63EBC30F7889FA0D28FD18C56783C7BF3AADA4C516E269DCEF72717031B0D0797563D21D74A80931032E90A0DBF772B7B86DAB7B29C47227066BA6859EF81B2BDC94960501592EFDBED2FA4BB612DD34C3BE69C1CB997189A2D14BE23FACD2D81694F87D706DA8A0E49133174CFCF86B6D83D4F26EDB5FB7C2E6F914A58B0187683E5BA21535910D122EF9B436BEB21B5ADD7373C8BE0A7519A9F94DF808F196B5B2DE8C41C9AAB21172F1FC44AA0719D844E60F4CC34C0BAFC3AC8BD334755883D330EA333DC51A586E630F8FD5BC49F2B1AA91E15F46AEFEA518272FC6B3DFCC15FE69DAD9A9F926C5E1B3979139277DBCDF27E7EB4BFC0C4996CD069835883475527C7D296034459225E90FC0FD45F259EDAD71154BC8938118F76C0E9B9CAB8BAAE2F86007BB7E603C1E0FA74670071FAB1AFB0468F47286F3F1C3039237D167B2182267E6BA157E3256F2924B9A2DD0B1F4C001E848DC9F85F05DE82FCCA50763549329EF9DF1BC9746B9CFB7308D72159C5A5DC242B76960F7E62827FD52B8F4BCF7A667EBDAD93E5D34CB68D92ECBCD7FEE9265DD359457ED508F38B088041E5BBFDB949F891FA490B48B24C2C754762F31DC4C0F0C8E3930D08A628D82D10C6CADDEA0BBDF8D9FF405C9FE9B2E5622BD99757F50109BF2BBE0B6804606EB5EF23E3D772D023013244905739680AC5801E039D02D768DDB47BE085BE698DFA91C29B13F34AFEC3DA8E69251F8EB21D1A11F4F994F459DA081025ACC6D0601A53B36ABA07929E8979E83D4D663803C0D52152369BF75CD6308D9FE58B15C63068D9'
        },
        options: new Options(
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));
    if (response.statusCode == 200) {
      var data = response.data;
      print('data::::: ${response.data['/api/v2/banner/get']}');
      await data['/api/v2/banner/get']['banners'].map((Object item) {
        list.add(item);
      }).toList();
      setState(() {
        this.list = list;
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    _list();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list.map((item) {
        return Image.network(item['imageUrl']);
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

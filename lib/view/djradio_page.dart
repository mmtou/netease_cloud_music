// 电台页面
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/dj_radio.dart';
import 'package:netease_cloud_music/model/djradio_category.dart';
import 'package:netease_cloud_music/model/djradio_hot.dart';
import 'package:netease_cloud_music/model/djradio_recommend.dart';
import 'package:netease_cloud_music/model/program_recommend.dart';

List<Category> djCategories = [];
List<Program> recommendPrograms = [];
List<DjRadio> recommendDjradios = [];
List<DjRadio> hotDjradios = [];

class DjRadioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DjRadioPageState();
  }
}

class DjRadioPageState extends State<DjRadioPage> with AutomaticKeepAliveClientMixin {

  // 电台下拉刷新
  Future<Null> loadDjradioData() async {
    djCategories.clear();
    recommendPrograms.clear();
    recommendDjradios.clear();
    hotDjradios.clear();
    DjradioCategory djradioCategory = await DjradioCategoryLogic.list();
    ProgramRecommend programRecommend = await ProgramRecommendLogic.list();
    DjradioRecommend djradioRecommend = await DjradioRecommendLogic.list();
    DjradioHot djradioHot = await DjradioHotLogic.list();
    setState(() {
      djCategories = djradioCategory.categories;
      recommendPrograms = programRecommend.programs;
      recommendDjradios = djradioRecommend.djRadios;
      hotDjradios = djradioHot.djRadios;
    });

    return;
  }

  @override
  void initState() {
    super.initState();
    loadDjradioData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView(
          children: <Widget>[
            // 电台分类
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
//                color: Colors.grey,
              ),
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(0.0),
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                crossAxisCount: 5,
                childAspectRatio: 1.5,
                children: List.generate(djCategories.length, (index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        djCategories[index].pic56x56Url,
                        width: 28.0,
                        height: 28.0,
                      ),
                      Text(
                        djCategories[index].name,
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  );
                }),
              ),
            ),

            // 推荐节目
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
//                color: Colors.grey,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2.0, color: Colors.black45)),
                    ),
                    margin: const EdgeInsets.all(12.0),
                    child: Text(
                      '推荐节目',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Column(
//                    shrinkWrap: true,
                    children: recommendPrograms.map((item) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: Image.network(
                              item.coverUrl,
                              width: 56.0,
                              height: 56.0,
                            ),
                            title: Text(
                              item.name,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              item.description,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              print('bbbb');
                            },
                          ),
                          Divider()
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // 推荐电台
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
//                color: Colors.grey,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2.0, color: Colors.black45)),
                    ),
                    margin: const EdgeInsets.all(12.0),
                    child: Text(
                      '推荐电台',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(0.0),
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    children: recommendDjradios.map((item) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              item.picUrl,
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.width / 4,
                            ),
                            Text(
                              item.rcmdtext,
                              style: TextStyle(fontSize: 10.0),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // 热门电台
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
//                color: Colors.grey,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2.0, color: Colors.black45)),
                    ),
                    margin: const EdgeInsets.all(12.0),
                    child: Text(
                      '热门电台',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(0.0),
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        crossAxisCount: 3,
                        childAspectRatio: 0.95,
                        children: hotDjradios.map((item) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.network(
                                  item.picUrl,
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.width / 4,
                                ),
                                Text(
                                  item.name,
                                  style: TextStyle(fontSize: 10.0),
                                  maxLines: 1,
                                ),
                                Text(
                                  'by ${item.dj != null
                                      ? item.dj.nickname
                                      : '佚名'}',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 10.0),
                                )
                              ],
                            ),
                          );
                        }).toList()),
                  ),
                ],
              ),
            ),
          ],
        ),
        onRefresh: loadDjradioData);
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

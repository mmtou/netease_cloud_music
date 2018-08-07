import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netease_cloud_music/config/config.dart';
import 'package:netease_cloud_music/util/http.dart';

class Event {
  User user;
  EventContent content;

  Event.fromJson(Map<String, dynamic> item)
      : user = User.fromJson(item['user']),
        content = EventContent.fromJson(json.decode(item['json']));
}

class User {
  int userId;
  String nickname;
  String avatarUrl;

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        nickname = json['nickname'],
        avatarUrl = json['avatarUrl'];
}

class EventContent {
  String msg;

  EventContent.fromJson(Map<String, dynamic> json) : msg = json['msg'];
}

class EventLogic {
  static Future<List<Event>> list() async {
    Response<String> response = await Http.post(Config.eventUrl, {
      'params':
          'A7EF7D9EC9420F7B09E7B2FF46870A66976504990CF6692AF9464AAC7F27147D615B5DD15328F0C256D1DADCF40B1E467F2A28D62CFECD4D6067E0742E23DE23C1961EE4CF0947DD1E6C8717704810046938AD9B38E451B678561419F8D0E32486C43E1B09D9BBB7B82B3C60B7914BF4D7182F15C8441C5D9DB3EE99629CF444F86B3D44F9427FB74000326BDE3E7660182DA26419396558357F4A30DC73564559C4B3911517D4A1F3E443DC68C548B09F4481BE01D337197201177BD173EC9E05CFD03CAC93F0105DC0CC9936AFEB9A073EFFBFF6E931D7CA2ED1B076AADEAC2D2D815E795B4411E88AE3F8FBEC12F194524B2C6FDA6109170045A8ECE9749D4999322145D1266E5610CB8443A9CA24482A5A03E6DD96DEAC205E52B6D68063BFA406946D279D31ED990BB7459F910FC7081B3B0A570E2B697FACB033A3F2EA79C4FDED5D474496E615F88976AF4F647ABBD012078B99107A2DACF83FC3F4944EB07443D126BA469F2FB677A6434AED20AF4FE3CB0F2B8A8F33D813ABDC257E219C61212C47EF13F91F9EEFE079B6EB92C8D678534B4EB44C4995719CEDEEF51E40F4241DFEFE52D00F0A9EC9D003CA6CE2B5A7EC0CF7BDB059AC6CEDEA3861'
    });
    var data = json.decode(response.data);
    List<Event> events = (data['event'] as List).map((Object item) {
      return Event.fromJson(item);
    }).toList();

    return events;
  }
}

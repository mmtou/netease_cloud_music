import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/event.dart';

class EventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventPageState();
  }
}

List<Event> events = [];

class EventPageState extends State<EventPage>
    with AutomaticKeepAliveClientMixin {
  Future<Null> _refresh() async {
    events.clear();

    events = await EventLogic.list();
    return;
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          if (index < events.length) {
            var event = events[index];
            var user = event.user;
            var content = event.content;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              title: Text(user.nickname),
              subtitle: Text(content.msg),
            );
          }
        }),
        onRefresh: _refresh);
  }

  @override
  bool get wantKeepAlive => true;
}

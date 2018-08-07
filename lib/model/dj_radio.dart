class DjRadio {
  int id;
  String name;
  String picUrl;
  String rcmdtext;
  Dj dj;

  DjRadio.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        picUrl = json['picUrl'],
        rcmdtext = json['rcmdtext'],
        dj = Dj.fromJson(json['dj']);
}

class Dj {
  String nickname;
  String avatarUrl;

  Dj.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        avatarUrl = json['avatarUrl'];
}

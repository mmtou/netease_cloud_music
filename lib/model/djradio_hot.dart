// 热门电台
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netease_cloud_music/model/dj_radio.dart';
import 'package:netease_cloud_music/util/http.dart';
import 'package:netease_cloud_music/config/config.dart';

class DjradioHot {
  List<DjRadio> djRadios;

  DjradioHot.fromJson(Map<String, dynamic> json)
      : djRadios = (json['djRadios'] as List).map((Object item) {
          return DjRadio.fromJson(item);
        }).toList();
}

class DjradioHotLogic {
  static Future<DjradioHot> list() async {
    Response<String> response = await Http.post(Config.djradioHotUrl, {
      'params':
          '29A88293C68441D48396A9D9B152F4C6BF71A46E21ABBECFCBD76C5C46748E99A243D2349D8AD7EF034E470F2B20A89E26E9590F714963CB7B697F132D2620977AFB1060C746C510B9F1CCA1D5669F1A9F2FAB381BB126AFFAE1FB9D661B2AB3163E5F95A4362909C2F64DBC3A6C4C086204FADD1C448B4059D1D69CBB8D96812C06D6AAB6A69D40F79D5E52E921DBD245FAF29C3961782524117B6B1D20D5856F104174F4B38D0590A935C851EA56DE7D63A52D73FAB1EDE1B7E263717BF07FE95E348973765F622B1688BD6D7E08577069879B71708F2002853C8B04A39FFC9DF9FB17B5C8EBC95768896C624598926976BF4CBFA0405996D90F5B8CB47026212339C2064B402E17809408FEFFA4E30C527AC09611172FF3E0D2BA6F4ABA6E2B55A5F4C380D1F374678D45611A96D39353F2A8F06C607E37DCDCD60FE5AE6295832CE24CC2FC145A3AB95BBC2E18FC38773CAADB530D9B349C3F8022994690DDB36FEBDBAE0EDC9F6F457BC8663B9F75C3B2C6CFF99B7AB76D67897058B381'
    });
    var data = json.decode(response.data);
    DjradioHot djradioHot = DjradioHot.fromJson(data);

    return djradioHot;
  }
}
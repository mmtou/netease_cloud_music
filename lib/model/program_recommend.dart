// 推荐节目
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netease_cloud_music/util/http.dart';
import 'package:netease_cloud_music/config/config.dart';

class ProgramRecommend {
  List<Program> programs;

  ProgramRecommend.fromJson(Map<String, dynamic> json)
      : programs = (json['programs'] as List).map((Object item) {
          return Program.fromJson(item);
        }).toList();
}

class Program {
  int id;
  String name;
  String coverUrl;
  String description;

  Program.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        coverUrl = json['coverUrl'],
        description = json['description'];
}

class ProgramRecommendLogic {
  static Future<ProgramRecommend> list() async {
    Response<String> response = await Http.post(Config.programRecommendUrl, {
      'params':
          'E0623E8008DEA21F1477BFADC75EA521B69BBA8274802CD6D3E1AF887DE743B31053FF3927623B1E80B210C78793E3D4324216E62F7A47A0EF67D504BA12FA6569874A90B5CF38F4231EF0DB671447953BE46EB747F34007AAD8E60D9CBD830F4E7911859C5D68237D1C4E62E3EEC759041E8BBD216394CD331458FC20B72557C2DABEB6FDDDC8AB9DEAD1B749DE63FD90B02FE0DBD1E9D0659106F6D1912F74508527906ABACE3BC14C7983A100DB3DD955F8586E85A8C0B5957DB4DDE56BEE49BD1C20553133405C7419740FD3A73E9CDB42D4E7D9629EC4DB6442B4156059B6255661BF858417FB414AF4857A3A3CDF2D80775180049507D2EF64EE50D90390C2F28474DAD763BF6B395AB60E07362E5E4F2983FE74A04E3331EFFC113B3A80BC312B3AF28FF57342F3E46BB70B0BAEFA61AC99096792F665F9DEF48DDE326D64E45E3740927E97A04A84A2DBC895C60390049121D013A0D429D97594E39EE990DC5EB4B314FE98453CC5E5E0257B28FB8F03628D6BBBABB80BA06A9D182D'
    });
    var data = json.decode(response.data);
    ProgramRecommend programRecommend = ProgramRecommend.fromJson(data);

    return programRecommend;
  }
}

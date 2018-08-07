// 电台分类
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netease_cloud_music/util/http.dart';
import 'package:netease_cloud_music/config/config.dart';

class DjradioCategory {
  List<Category> categories;

  DjradioCategory.fromJson(Map<String, dynamic> json)
      : categories = (json['categories'] as List).map((Object item) {
          return Category.fromJson(item);
        }).toList();
}

class Category {
  int id;
  String name;
  String pic56x56Url;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        pic56x56Url = json['pic56x56Url'];
}

class DjradioCategoryLogic {
  static Future<DjradioCategory> list() async {
    Response<String> response =
        await Http.post<String>(Config.djradioCategoryUrl, {
      'params':
          '3DE39375A71194326CEECC3B8D7CA056CA6D58D0991221BDDD4A4A3CC04125D01053FF3927623B1E80B210C78793E3D4324216E62F7A47A0EF67D504BA12FA6569874A90B5CF38F4231EF0DB671447953BE46EB747F34007AAD8E60D9CBD830F4E7911859C5D68237D1C4E62E3EEC759041E8BBD216394CD331458FC20B72557C2DABEB6FDDDC8AB9DEAD1B749DE63FD90B02FE0DBD1E9D0659106F6D1912F74508527906ABACE3BC14C7983A100DB3DD955F8586E85A8C0B5957DB4DDE56BEE49BD1C20553133405C7419740FD3A73E9CDB42D4E7D9629EC4DB6442B4156059B6255661BF858417FB414AF4857A3A3CDF2D80775180049507D2EF64EE50D9036260ED5833909F0135953406F4F545342E5E4F2983FE74A04E3331EFFC113B3A80BC312B3AF28FF57342F3E46BB70B0B2B1F86E56A1C1D68F7252A4FEA4E8D186BC020C0B14989E301F861C6DEA197EC539BE044B92799D6680AFA424D5CFC2B228BBA93C7FDC1F29FAEA97220D59743F9386F75F6915EC8F1F7ACA2B5B3E24D'
    });

    var data = json.decode(response.data);
    DjradioCategory djradioCategory = DjradioCategory.fromJson(data);
    return djradioCategory;
//    }
  }
}

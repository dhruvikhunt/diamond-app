import 'dart:convert';

import 'package:diamond_app/data/models/diamond_model.dart';
import 'package:flutter/cupertino.dart';

import '../utils/app_preference.dart';

abstract class LocalDataSource {
  Future<void> saveDiamondData({required List<DiamondModel> response});

  Future<List<DiamondModel>> loadDiamondData();
}

class LocalDataSourceImplementer implements LocalDataSource {
  final AppSharePref appPrefs = AppSharePref();

  LocalDataSourceImplementer();

  @override
  Future<void> saveDiamondData({required List<DiamondModel> response}) async {
    String jsonString = jsonEncode(response.map((d) => d.toJson()).toList());
    appPrefs.setStringData(keyName: AppPrefKeys.diamondData, value: jsonString);
  }

  @override
  Future<List<DiamondModel>> loadDiamondData() async {
    String jsonString = await appPrefs.getStringData(
      keyName: AppPrefKeys.diamondData,
    );
    if(jsonString.isEmpty){
      return [];
    }
    List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((e) => DiamondModel.fromJson(e)).toList();
  }
}

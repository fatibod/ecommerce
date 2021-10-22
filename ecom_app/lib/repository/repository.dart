import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Repository {
  String _baseUrl = 'https://ecom-api.lutforrahman.com/api';
  httpGet(String api) async {
    return await http.get(_baseUrl + "/" + api);
  }

  httpGetById(String api, categoryId) async {
    return await http.get(_baseUrl + "/" + api + "/" + categoryId.toString());
  }

  httpPost(String api, data) async {
    return await http.post(_baseUrl + "/" + api, body: data);
  }

  saveLocal(table, data) async {
    var database;
    var conn = await database;
    return await conn.insert(table, data);
  }

  updateLocal(table, columnName, data) async {
    var database;
    var conn = await database;
    return await conn.update(table, data,
        where: '$columnName =?', whereArgs: [data['productId']]);
  }

  getLocalByCondition(table, columnName, conditionalValue) async {
    var database;
    var conn = await database;
    return await conn.rewQuery(
        'SELECT * FROM $table WHERE  $columnName =?', ['$conditionalValue']);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class Server {
  Future<List<Centers>> getSessionByDistrict(String dist_id, String date);
  Future<List<Centers>> getSessionByPincode(String pincode, String date);
}

class ServerBase extends Server {
  Future<Response> _getData({String url}) async {
    print(baseUrl + url);
    var response = await http.get(Uri.parse(baseUrl + url));
    return response;
  }

  Future<List<Centers>> getSessionByPincode(String pincode, String date) async {
    Response _response =
        await _getData(url: "calendarByPin?pincode=303503&date=31-03-2021");
    try {
      if (_response.statusCode == 500) {
        throw SocketException("internet");
      }
    } on SocketException {
      throw CustomException(); //"Internet error"
    } on FormatException {
      throw CustomException(); //"Try Again Later"
    } on HttpException {
      throw CustomException(); //"Server Error"
    }
    final _results = jsonDecode(_response.body);
    var list = _results['centers'] as List;
    List<Centers> centers = list.map((e) {
      return Centers.fromJson(e);
    }).toList();
    return centers;
  }

  Future<List<Centers>> getSessionByDistrict(
      String dist_id, String date) async {
    Response _response = await _getData(
        url: "calendarByDistrict?district_id=512&date=31-03-2021");
    try {
      if (_response.statusCode == 500) {
        throw SocketException("internet");
      }
    } on SocketException {
      throw CustomException(); //"Internet error"
    } on FormatException {
      throw CustomException(); //"Try Again Later"
    } on HttpException {
      throw CustomException(); //"Server Error"
    }
    final _results = jsonDecode(_response.body);
    var list = _results['centers'] as List;
    print(list);
    List<Centers> centers = list.map((e) {
      return Centers.fromJson(e);
    }).toList();
    print(centers.length);
    return centers;
  }
}

class CustomException {}

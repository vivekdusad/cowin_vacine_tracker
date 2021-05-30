import 'dart:convert';
import 'dart:io';
import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/models/stateDistrict.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

//le commit me agian
//le commit me agian
abstract class Server {
  Future<List<Centers>> getSessionByDistrict(String dist_id, String date);
  Future<List<Centers>> getSessionByPincode(String pincode, DateTime date);
  Future<List<States>> getStates();
  Future<List<Districts>> getDistrict(int state_id);
}

class ServerBase extends Server {
  Future<Response> _getData({String url}) async {
    print(url);
    var response = await http.get(Uri.parse(url));
    return response;
  }

  Future<List<States>> getStates() async {
    Response _response = await _getData(url: locationbaseUrl + "states");
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
    // print(_results["states"]);
    List<dynamic> list = _results["states"] as List;
    List<States> centers = list.map((e) {
      return States.fromJson(e);
    }).toList();

    return centers;
  }

  Future<List<Districts>> getDistrict(int state_id) async {
    Response _response =
        await _getData(url: locationbaseUrl + "districts/$state_id");
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
    print(_results);
    List<dynamic> list = _results["districts"] as List;
    List<Districts> centers = list.map((e) {
      return Districts.fromJson(e);
    }).toList();
    return centers;
  }

  Future<List<Centers>> getSessionByPincode(
      String pincode, DateTime date) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    Response _response = await _getData(
        url:
            sessionsbaseUrl + "calendarByPin?pincode=$pincode&date=$formatted");
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
        url: sessionsbaseUrl +
            "calendarByDistrict?district_id=$dist_id&date=31-03-2021");
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
}

class CustomException {}

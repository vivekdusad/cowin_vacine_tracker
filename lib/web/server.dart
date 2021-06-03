import 'dart:convert';
import 'dart:io';
import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:cowin_vaccine_tracker/models/data.dart';
import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/models/stateCorna.dart';
import 'package:cowin_vaccine_tracker/models/stateDistrict.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

//le commit me agian
//le commit me agian
abstract class Server {
  Future<List<Centers>> getSessionByDistrict(String distId, DateTime date);
  Future<List<Centers>> getSessionByPincode(String pincode, DateTime date);
  Future<List<States>> getStates();
  Future<List<Districts>> getDistrict(int stateId);
  Future<CoronaData> getCoronaData();
  Future<List<StateCorona>> getStateCorona();
}

class ServerBase extends Server {
  Future<Response> _getData({String url}) async {
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

    List<dynamic> list = _results["states"] as List;
    List<States> centers = list.map((e) {
      return States.fromJson(e);
    }).toList();

    return centers;
  }

  Future<List<Districts>> getDistrict(int stateId) async {
    Response _response =
        await _getData(url: locationbaseUrl + "districts/$stateId");
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
      String distId, DateTime date) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);

    Response _response = await _getData(
        url: sessionsbaseUrl +
            "calendarByDistrict?district_id=$distId&date=$formatted");
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

  Future<CoronaData> getCoronaData() async {
    Response _response = await _getData(url: dataUrl);
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
    CoronaData coronaData = CoronaData.fromJson(_results);
    
    return coronaData;
  }

  @override
  Future<List<StateCorona>> getStateCorona() async {
    Response _response = await _getData(url: coronaDataURl);
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

    var list = _results as List;
    List<StateCorona> corona =
        list.map((e) => StateCorona.fromJson(e)).toList();

    return corona;
  }
}

class CustomException {}

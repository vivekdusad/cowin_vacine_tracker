import 'dart:convert';
import 'dart:io';
import 'package:cowin_vaccine_tracker/constants/constants.dart';
import 'package:cowin_vaccine_tracker/models/CoronaCaseCountry.dart';
import 'package:cowin_vaccine_tracker/models/data.dart';
import 'package:cowin_vaccine_tracker/models/mohfw.dart';
import 'package:cowin_vaccine_tracker/models/pincode.dart';
import 'package:cowin_vaccine_tracker/models/stateCorna.dart';
import 'package:cowin_vaccine_tracker/models/stateDistrict.dart';
import 'package:cowin_vaccine_tracker/models/totaldata.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

//le commit me agian
//le commit me agian
abstract class Server {
  Future<List<Centers>> getSessionByDistrict(String distId, DateTime date);
  Future<List<Centers>> getSessionByPincode(String pincode, DateTime date);
  Future<List<States>> getStates();
  Future<List<Centers>> getbylatlong(double lat, double long);
  Future<List<Districts>> getDistrict(int stateId);
  Future<CoronaData> getCoronaData();
  Future<List<StateCorona>> getStateCorona();
  Future<List<TotalDataInternal>> fetchTotalData();
  Future<List<Rows>> readMohew();
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
    if (list == null) {
      throw SocketException("Wrong Pincode");
    }
    List<Centers> centers = list.map((e) {
      return Centers.fromJson(e);
    }).toList();
    return centers;
  }

  Future<List<Centers>> getbylatlong(double lat, double long) async {
    Response _response = await _getData(
        url:
        latlongURL + "findByLatLong?lat=$lat&long=$long");


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
    if (list == null) {
      throw SocketException("Wrong lat long");
    }
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

  Future<List<CoronaCaseCountry>> fetchCases() async {
    String caseURL =
        '$baseURL?f=json&where=(Confirmed%3E%200)%20OR%20(Deaths%3E0)%20OR%20(Recovered%3E0)&returnGeometry=false&spatialRef=esriSpatialRelIntersects&outFields=*&orderByFields=Country_Region%20asc,Province_State%20asc&resultOffset=0&resultRecordCount=250&cacheHint=false';

    final Response response = await _getData(url: caseURL);
    final _results = jsonDecode(response.body);
    var list = _results['features'] as List;
    List<CoronaCaseCountry> centers = list.map((e) {
      var t = e["attributes"] as Map<String, dynamic>;
      return CoronaCaseCountry.fromMap(t);
    }).toList();
    print(centers[0].toString());
    return centers;
  }

  Future<List<TotalDataInternal>> fetchTotalData() async {
    Response _response = await _getData(url: totaldataUrl);
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
    var list = _results['rows'] as List;
    List<TotalDataInternal> centers = list.map((e) {
      return TotalDataInternal.fromJson(e);
    }).toList();
    return centers
        .where((element) => element.key[1] == "total_confirmed_cases")
        .toList();
  }

  Future<List<Rows>> readMohew() async {
    Response _response = await _getData(
        url:
            "https://raw.githubusercontent.com/datameet/covid19/master/data/mohfw.json");
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
    var list = _results['rows'] as List;
    List<Rows> centers = list.map((e) {
      return Rows.fromJson(e);
    }).toList();
    final List<Rows> lis = centers.sublist(centers.length - 72);
    print(lis[0].id);
    return lis;
  }
}

class CustomException {}

const baseURL =
    'https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query';

const totaldataUrl =
    "https://raw.githubusercontent.com/datameet/covid19/master/data/all_totals.json";

import 'dart:convert';

import 'package:flutter/foundation.dart';

class CoronaCaseCountry {
  // ignore: non_constant_identifier_names
  int OBJECTID;
  // ignore: non_constant_identifier_names
  String Province_State;
  // ignore: non_constant_identifier_names
  String Country_Region;
  // ignore: non_constant_identifier_names
  int Last_Update;
  // ignore: non_constant_identifier_names
  double Lat;
  // ignore: non_constant_identifier_names
  double Long_;
  // ignore: non_constant_identifier_names
  int Confirmed;
  // ignore: non_constant_identifier_names
  int Recovered;
  // ignore: non_constant_identifier_names
  int Deaths;
  // ignore: non_constant_identifier_names
  int Active;
  String Admin2;
  // ignore: non_constant_identifier_names
  String FIPS;
  // ignore: non_constant_identifier_names
  String Combined_Key;
  CoronaCaseCountry({
    // ignore: non_constant_identifier_names
    @required this.OBJECTID,
    // ignore: non_constant_identifier_names
    @required this.Province_State,
    // ignore: non_constant_identifier_names
    @required this.Country_Region,
    // ignore: non_constant_identifier_names
    @required this.Last_Update,
    // ignore: non_constant_identifier_names
     this.Lat,
    // ignore: non_constant_identifier_names
     this.Long_,
    // ignore: non_constant_identifier_names
    @required this.Confirmed,
    // ignore: non_constant_identifier_names
    @required this.Recovered,
    // ignore: non_constant_identifier_names
    @required this.Deaths,
    // ignore: non_constant_identifier_names
    @required this.Active,
    // ignore: non_constant_identifier_names
    @required this.Admin2,
    // ignore: non_constant_identifier_names
    @required this.FIPS,
    // ignore: non_constant_identifier_names
    @required this.Combined_Key,
  });

  CoronaCaseCountry copyWith({
    int OBJECTID,
    String Province_State,
    String Country_Region,
    int Last_Update,
    double Lat,
    double Long_,
    int Confirmed,
    int Recovered,
    int Deaths,
    int Active,
    String Admin2,
    String FIPS,
    String Combined_Key,
  }) {
    return CoronaCaseCountry(
      OBJECTID: OBJECTID ?? this.OBJECTID,
      Province_State: Province_State ?? this.Province_State,
      Country_Region: Country_Region ?? this.Country_Region,
      Last_Update: Last_Update ?? this.Last_Update,
      Lat: Lat ?? this.Lat,
      Long_: Long_ ?? this.Long_,
      Confirmed: Confirmed ?? this.Confirmed,
      Recovered: Recovered ?? this.Recovered,
      Deaths: Deaths ?? this.Deaths,
      Active: Active ?? this.Active,
      Admin2: Admin2 ?? this.Admin2,
      FIPS: FIPS ?? this.FIPS,
      Combined_Key: Combined_Key ?? this.Combined_Key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'OBJECTID': OBJECTID,
      'Province_State': Province_State,
      'Country_Region': Country_Region,
      'Last_Update': Last_Update,
      'Lat': Lat,
      'Long_': Long_,
      'Confirmed': Confirmed,
      'Recovered': Recovered,
      'Deaths': Deaths,
      'Active': Active,
      'Admin2': Admin2,
      'FIPS': FIPS,
      'Combined_Key': Combined_Key,
    };
  }

  factory CoronaCaseCountry.fromMap(Map<String, dynamic> map) {
    return CoronaCaseCountry(
      OBJECTID: map['OBJECTID'] as int,
      Province_State: map['Province_State'],
      Country_Region: map['Country_Region'],
      Last_Update: map['Last_Update'] as int,
      Lat: map['Lat']is int?map['Lat'].toDouble():map['Lat'] ,
      Long_: map['Long_'] is int?map['Long_'].toDouble():map['Long_'],
      Confirmed: map['Confirmed'],
      Recovered: map['Recovered'],
      Deaths: map['Deaths'],
      Active: map['Active'],
      Admin2: map['Admin2'],
      FIPS: map['FIPS'],
      Combined_Key: map['Combined_Key'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoronaCaseCountry.fromJson(String source) => CoronaCaseCountry.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CoronaCaseCountry(OBJECTID: $OBJECTID, Province_State: $Province_State, Country_Region: $Country_Region, Last_Update: $Last_Update, Lat: $Lat, Long_: $Long_, Confirmed: $Confirmed, Recovered: $Recovered, Deaths: $Deaths, Active: $Active, Admin2: $Admin2, FIPS: $FIPS, Combined_Key: $Combined_Key)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CoronaCaseCountry &&
      other.OBJECTID == OBJECTID &&
      other.Province_State == Province_State &&
      other.Country_Region == Country_Region &&
      other.Last_Update == Last_Update &&
      other.Lat == Lat &&
      other.Long_ == Long_ &&
      other.Confirmed == Confirmed &&
      other.Recovered == Recovered &&
      other.Deaths == Deaths &&
      other.Active == Active &&
      other.Admin2 == Admin2 &&
      other.FIPS == FIPS &&
      other.Combined_Key == Combined_Key;
  }

  @override
  int get hashCode {
    return OBJECTID.hashCode ^
      Province_State.hashCode ^
      Country_Region.hashCode ^
      Last_Update.hashCode ^
      Lat.hashCode ^
      Long_.hashCode ^
      Confirmed.hashCode ^
      Recovered.hashCode ^
      Deaths.hashCode ^
      Active.hashCode ^
      Admin2.hashCode ^
      FIPS.hashCode ^
      Combined_Key.hashCode;
  }
}

class StateCorona {
  String provinceState;
  String countryRegion;
  int lastUpdate;
  double lat;
  double long;
  int confirmed;
  int recovered;
  int deaths;
  int active;
  String combinedKey;
  double incidentRate;
  int uid;
  String iso3;

  StateCorona(
      {this.provinceState,
      this.countryRegion,
      this.lastUpdate,
      this.lat,
      this.long,
      this.confirmed,
      this.recovered,
      this.deaths,
      this.active,
      this.combinedKey,
      this.incidentRate,
      this.uid,
      this.iso3});

  StateCorona.fromJson(Map<String, dynamic> json) {
    provinceState = json['provinceState'];
    countryRegion = json['countryRegion'];
    lastUpdate = json['lastUpdate'];
    lat = json['lat'];
    long = json['long'];
    confirmed = json['confirmed'];
    recovered = json['recovered'];
    deaths = json['deaths'];
    active = json['active'];
    combinedKey = json['combinedKey'];
    incidentRate = json['incidentRate'];
    uid = json['uid'];
    iso3 = json['iso3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceState'] = this.provinceState;
    data['countryRegion'] = this.countryRegion;
    data['lastUpdate'] = this.lastUpdate;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['confirmed'] = this.confirmed;
    data['recovered'] = this.recovered;
    data['deaths'] = this.deaths;
    data['active'] = this.active;
    data['combinedKey'] = this.combinedKey;
    data['incidentRate'] = this.incidentRate;
    data['uid'] = this.uid;
    data['iso3'] = this.iso3;
    return data;
  }
}
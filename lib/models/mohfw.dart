class Autogenerated {
  int totalRows;
  int offset;
  List<Rows> rows;

  Autogenerated({this.totalRows, this.offset, this.rows});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    totalRows = json['total_rows'];
    offset = json['offset'];
    if (json['rows'] != null) {
      rows = new List<Rows>();
      json['rows'].forEach((v) {
        rows.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_rows'] = this.totalRows;
    data['offset'] = this.offset;
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  String id;
  String key;
  Value value;

  Rows({this.id, this.key, this.value});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    if (this.value != null) {
      data['value'] = this.value.toJson();
    }
    return data;
  }
}

class Value {
  String sId;
  String sRev;
  String reportTime;
  String state;
  int confirmedIndia;
  int confirmedForeign;
  int cured;
  int death;
  String source;
  String type;
  int confirmed;

  Value(
      {this.sId,
      this.sRev,
      this.reportTime,
      this.state,
      this.confirmedIndia,
      this.confirmedForeign,
      this.cured,
      this.death,
      this.source,
      this.type,
      this.confirmed});

  Value.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sRev = json['_rev'];
    reportTime = json['report_time'];
    state = json['state'];
    confirmedIndia = json['confirmed_india'];
    confirmedForeign = json['confirmed_foreign'];
    cured = json['cured'];
    death = json['death'];
    source = json['source'];
    type = json['type'];
    confirmed = json['confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['_rev'] = this.sRev;
    data['report_time'] = this.reportTime;
    data['state'] = this.state;
    data['confirmed_india'] = this.confirmedIndia;
    data['confirmed_foreign'] = this.confirmedForeign;
    data['cured'] = this.cured;
    data['death'] = this.death;
    data['source'] = this.source;
    data['type'] = this.type;
    data['confirmed'] = this.confirmed;
    return data;
  }
}
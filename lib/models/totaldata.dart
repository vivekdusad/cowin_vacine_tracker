class TotalData {
  List<TotalDataInternal> rows;

  TotalData({this.rows});

  TotalData.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = new List<TotalDataInternal>();
      json['rows'].forEach((v) {
        rows.add(new TotalDataInternal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalDataInternal {
  List<String> key;
  int value;

  TotalDataInternal({this.key, this.value});

  TotalDataInternal.fromJson(Map<String, dynamic> json) {
    key = json['key'].cast<String>();
    value = json['value'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
import 'dart:convert';

GetGenderModel getGenderModelFromJson(String str) => GetGenderModel.fromJson(json.decode(str));

String getGenderModelToJson(GetGenderModel data) => json.encode(data.toJson());

class GetGenderModel {
  String? status;
  List<Datum>? data;

  GetGenderModel({
    this.status,
    this.data,
  });

  factory GetGenderModel.fromJson(Map<String, dynamic> json) => GetGenderModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? gendersId;
  String? name;
  String? status;

  Datum({
    this.gendersId,
    this.name,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    gendersId: json["genders_id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "genders_id": gendersId,
    "name": name,
    "status": status,
  };
}

import 'dart:convert';
import 'package:http/http.dart' as http;

MydayList usersMydayFromJson(String str) => MydayList.fromJson(json.decode(str));

String usersMydayToJson(MydayList data) => json.encode(data.toJson());


class MydayList {
  MydayList({
    required this.data,
  });

  final List<MydayInfo> data;

  factory MydayList.fromJson(Map<String, dynamic> json) => MydayList(
    data: List<MydayInfo>.from(json["data"].map((x) => MydayInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}




class MydayInfo {
  int? id;
  String? title;
  String? description;


  MydayInfo({
    this.id,
    required this.title,
    required this.description,
  });


  factory MydayInfo.fromJson(Map<String, dynamic> json) => MydayInfo(
    id: json["id"],
    title: json["title"],
    description: json["description"],

  );

  Set<Map<String, Object?>> toJson() => {
    {
      'id': id,
      'title': title,
      'description': description,
      // it doesn't support the boolean either, so we save that as integer.
    }
  };

  // this function is for debugging only
  @override
  String toString() {
    return 'Todo(id : $id, title : $title, description : $description)';
  }

}
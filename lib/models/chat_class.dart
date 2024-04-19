import 'dart:convert';

import 'package:advocate_app/models/chat_history.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiResponse {
  String msg;
  List<Chat> contents;

  ApiResponse({required this.msg, required this.contents});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      msg: json['msg'],
      contents: List<Chat>.from(json['contents'].map((x) => Chat.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'contents': contents.map((x) => x.toJson()).toList(),
    };
  }
}



// Helper function to parse a list of judgments from a JSON array
List<Judgment> parseJudgments(String jsonResponse) {
  final data = jsonDecode(jsonResponse) as List;
  return data.map((json) => Judgment.fromJson(json)).toList();
}

import 'dart:convert';

class Chat {
  final int id;
  final int chatId;
  final String timestamp;
  final String sender;
  final String type;
  final String? contextMessageId;
  final dynamic content;

  Chat({
    required this.id,
    required this.chatId,
    required this.timestamp,
    required this.sender,
    required this.type,
    this.contextMessageId,
    required this.content,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var contentData = json['content'];
    if(contentData.toString().startsWith("[{")){
      contentData = parseJudgments(contentData.toString());
    }

    return Chat(
      id: json['id'] ?? 0,
      chatId: json['chatId'],
      timestamp: json['timestamp'],
      sender: json['sender'],
      type: json['type'],
      contextMessageId: json['contextMessageId'],
      content: contentData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'chatId': chatId,
      'timestamp': timestamp,
      'sender': sender,
      'type': type,
      'contextMessageId': contextMessageId,
       'content': content is String ? content : List<dynamic>.from((content as List<Judgment>).map((x) => x.toJson())),
    };
  }
}

class Judgment {
  final String title;
  final int year;
  final String summary;
  final String url;

  Judgment({
    required this.title,
    required this.year,
    required this.summary,
    required this.url,
  });

  factory Judgment.fromJson(Map<String, dynamic> json) {
    return Judgment(
      title: json['title'],
      year: int.tryParse(json['year'].toString()) ?? 0,
      summary: json['summary'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'summary': summary,
      'url': url,
    };
  }
}

// Helper function to parse a list of judgments from a JSON array
List<Judgment> parseJudgments(String jsonResponse) {
  final data = jsonDecode(jsonResponse) as List;
  return data.map((json) => Judgment.fromJson(json)).toList();
}

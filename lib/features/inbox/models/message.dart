class MessageModel {
  final String text;
  final String userId;
  final int creatdeAt;

  MessageModel({
    required this.text,
    required this.userId,
    required this.creatdeAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        creatdeAt = json['creatdeAt'],
        userId = json['userId'];

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "userId": userId,
      "creatdeAt": creatdeAt,
    };
  }
}

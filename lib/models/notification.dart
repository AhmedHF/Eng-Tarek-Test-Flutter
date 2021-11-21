class NotificationModel {
  late final String id;
  late final String from;
  late final String title;
  late final String message;
  late final String link;
  late final bool isRead;

  NotificationModel({
    required this.id,
    required this.from,
    required this.title,
    required this.message,
    required this.link,
    required this.isRead,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    title = json['title'];
    message = json['message'];
    link = json['link'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'title': title,
        'message': message,
        'link': link,
        'isRead': isRead,
      };

  @override
  String toString() => 'id: $id from: $from title: $title isRead: $isRead';
}

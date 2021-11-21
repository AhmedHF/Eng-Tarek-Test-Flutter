class FollowingsModel {
  late final String id;
  late final String count;
  late final String image;

  FollowingsModel({
    required this.id,
    required this.count,
    required this.image,
  });

  FollowingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'count': count,
        'image': image,
      };

  @override
  String toString() => 'id: $id count: $count';
}

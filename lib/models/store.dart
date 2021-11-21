class StoreModel {
  late final int id;
  late final String image;
  late final String name;
  StoreModel({
    required this.id,
    required this.image,
    required this.name,
  });

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
      };

  @override
  String toString() => 'id: $id image: $image name: $name';
}

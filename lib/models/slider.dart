class SliderModel {
  late final int id;
  late final String image;

  SliderModel({
    required this.id,
    required this.image,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json['id'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
      };

  @override
  String toString() => 'id: $id image: $image';
}

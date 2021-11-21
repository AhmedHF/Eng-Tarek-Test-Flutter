import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String color;
  final String image;
  final String createdAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.image,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      image: json['image'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color,
        'image': image,
        'createdAt': createdAt,
      };

  @override
  String toString() =>
      'id: $id name: $name color: $color image: $image createdAt: $createdAt';

  @override
  List<Object?> get props => [id, name, color, image, createdAt];
}

class MemberShipModel {
  late final int id;
  late final String name;
  late final String description;
  late final String price;
  late final int days;

  MemberShipModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.days,
  });

  MemberShipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'days': days,
      };

  @override
  String toString() =>
      'id: $id name: $name description: $description price: $price';
}

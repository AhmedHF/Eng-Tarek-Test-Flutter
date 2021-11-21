class BranchModel {
  late final int id;
  late final String from;
  late final String to;
  late final String name;

  BranchModel({
    required this.id,
    required this.from,
    required this.to,
    required this.name,
  });

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'to': to,
        'name': name,
      };

  @override
  String toString() => 'id: $id from: $from to: $to name: $name';
}

class CheckBoxModal {
  late final int id;
  late final String title;
  late String subtitle;
  late final String count;
  bool value;
  late String name;
  late String color;
  late String image;

  CheckBoxModal({
    required this.id,
    required this.title,
    required this.count,
    this.subtitle = '',
    this.value = false,
    this.name = '',
    this.color = '',
    this.image = '',
  });

  // CheckBoxModal.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'];
  //   value = json['value'];
  // }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'title': title,
  //       'value': value,
  //     };

  // @override
  // String toString() => 'id: $id title: $title value: $value';
}

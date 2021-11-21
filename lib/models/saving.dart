class SavingModel {
  late final int id;
  late final int amount;
  late final int price;
  late final int oldPrice;
  late final String name;
  late final String purchaseDate;

  SavingModel({
    required this.id,
    required this.amount,
    required this.price,
    required this.oldPrice,
    required this.purchaseDate,
    required this.name,
  });

  SavingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    purchaseDate = json['purchaseDate'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'price': price,
        'oldPrice': oldPrice,
        'purchaseDate': purchaseDate,
        'name': name,
      };

  @override
  String toString() =>
      'id: $id amount: $amount price: $price name: $name oldPrice: $oldPrice purchaseDate: $purchaseDate';
}

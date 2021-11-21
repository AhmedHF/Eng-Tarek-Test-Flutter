class CartModel {
  late final int id;
  int qty;
  late final int price;
  late final String description;
  late final int offer;
  late final int remain;
  late final int couponNumberPerUser;

  CartModel({
    required this.id,
    this.qty = 0,
    required this.price,
    required this.description,
    required this.offer,
    required this.remain,
    required this.couponNumberPerUser,
  });

  // CartModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   qty = json['qty'];
  //   price = json['price'];
  //   description = json['description'];
  //   offer = json['offer'];
  // }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'qty': qty,
  //       'price': price,
  //       description: description,
  //       'offer': offer,
  //     };

  @override
  String toString() => 'id: $id qty: $qty price: $price offer: $offer';

  // @override
  // List<Object?> get props => [id, qty, price, offer];
}

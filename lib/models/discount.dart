class DiscountModel {
  late final int id;
  late final String name;
  late final int? offer;
  late final String description;
  late final String image;
  late final bool expire;
  late final String expireDate;
  late final String price;
  late final String priceBeforeDiscount;
  late final String storeName;
  late final String storeImage;

  DiscountModel({
    required this.id,
    required this.name,
    this.offer,
    required this.description,
    required this.image,
    required this.expire,
    required this.expireDate,
    required this.price,
    required this.priceBeforeDiscount,
    required this.storeName,
    required this.storeImage,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        id: json['id'],
        name: json['name'],
        offer: json['offer'],
        description: json['description'],
        image: json['image'],
        expire: json['expire'],
        expireDate: json['expireDate'],
        price: json['price'],
        priceBeforeDiscount: json['priceBeforeDiscount'],
        storeName: json['storeName'],
        storeImage: json['storeImage'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'offer': offer,
        'image': image,
        'description': description,
        'expire': expire,
        'expireDate': expireDate,
        'price': price,
        'priceBeforeDiscount': priceBeforeDiscount,
        'storeName': storeName,
        'storeImage': storeImage,
      };

  @override
  String toString() => 'id: $id name: $name offer: $offer ';
}

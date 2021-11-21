class UserModel {
  late final int id;
  String? name;
  String? email;
  late final String phone;
  String? image;
  String? lat;
  String? lng;
  String? verificationCode;
  bool? isActive;
  bool? verified;
  Map<String, dynamic>? country;
  UserModel({
    required this.id,
    this.name,
    this.email,
    required this.phone,
    this.image,
    this.lat,
    this.lng,
    this.verificationCode,
    this.isActive,
    this.verified,
    this.country,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    verificationCode = json['verification_code'];
    isActive = json['is_active'];
    verified = json['verified'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'lat': lat,
        'lng': lng,
        'verification_code': verificationCode,
        'is_active': isActive,
        'verified': verified,
        'country': country
      };
  @override
  String toString() =>
      'id: $id name: $name email: $email phone: $phone image: $image lat: $lat lng: $lng verificationCode: $verificationCode verified: $verified isActive: $isActive country $country';
}

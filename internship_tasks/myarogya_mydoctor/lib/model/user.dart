class User{
  String id;
  String category;
  String mobile;

  User._({this.id, this.category,this.mobile});

  factory User.fromJson(dynamic json) {

    return new User._(
      id: json['id'] as String,
      category: json['category'] as String,
      mobile: json['mobile'] as String,
    );
  }
}

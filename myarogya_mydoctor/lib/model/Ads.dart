class MyAds{
  final String name;
  final String productCatogory;
  final String slogan;
  final List media;
  final String mobile;
  MyAds._({this.name, this.productCatogory, this.slogan, this.media, this.mobile});

  factory MyAds.fromJson(dynamic json){
    return new MyAds._(
      name: json["AdName"] as String,
      productCatogory: json["ProductCatogory"] as String,
      slogan: json["Slogan"] as String,
      media: json["Media"] as List,
      mobile: json["Mobile"] as String,
    );
  }

}

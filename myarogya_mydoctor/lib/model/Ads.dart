class MyAds{
  final String name;
  final String productCatogory;
  final String slogan;
  final String image;
  final String video;
  final String mobile;
  final int views;
  MyAds._({this.name, this.productCatogory, this.slogan, this.image,this.video, this.mobile,this.views});

  factory MyAds.fromJson(dynamic json){
    return new MyAds._(
      name: json["AdName"] as String,
      productCatogory: json["ProductCatogory"] as String,
      slogan: json["Slogan"] as String,
      image: json["Image"] as String,
      video: json["Video"] as String,
      mobile: json["Mobile"] as String,
      views: json["Views"] as int,
    );
  }

}


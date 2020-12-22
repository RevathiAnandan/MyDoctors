class Complains{
  final String ComplainNumber;
  final String About;
  final String SendTo;
  final String Category;
  final String Depart;
  final String CompanyName;
  final String Govt;
  final String image;
  final String video;
  final String mobile;
  final String Risky;
  final String Urgent;
  final String Priority;
  final String Views;
  Complains._({this.ComplainNumber, this.About, this.SendTo,this.Category,this.Depart,this.CompanyName,this.Govt, this.image,this.video, this.mobile,this.Risky,this.Priority,this.Urgent,this.Views});

  factory Complains.fromJson(dynamic json){
    return new Complains._(
      ComplainNumber: json["ComplainNumber"] as String,
      About: json["About"] as String,
      SendTo: json["SendTo"] as String,
      Category: json["Category"] as String,
      Depart: json["Depart"] as String,
      CompanyName: json["CompanyName"] as String,
      Govt: json["Govt"] as String,
      image: json["Image"] as String,
      video: json["Video"] as String,
      mobile: json["Mobile"] as String,
      Risky: json["Risky"] as String,
      Urgent: json["Urgent"] as String,
      Priority: json["Priority"] as String,
      Views: json["Views"] as String,
    );
  }

}


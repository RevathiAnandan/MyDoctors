class Complains{
  final String ComplainNumber;
  final String About;
  final String location;
  final String SendTo;
  final String Category;
  final String Depart;
  final String CompanyName;
  final String Govt;
  final String image;
  final String video;
  final String mobile;
  final int Risky;
  final int Urgent;
  final int Priority;
  final int Views;
  Complains._({this.ComplainNumber, this.About,this.location, this.SendTo,this.Category,this.Depart,this.CompanyName,this.Govt, this.image,this.video, this.mobile,this.Risky,this.Priority,this.Urgent,this.Views});

  factory Complains.fromJson(dynamic json){
    return new Complains._(
      ComplainNumber: json["ComplainNumber"] as String??"",
      About: json["About"] as String??"",
      location: json["Location"] as String??"",
      SendTo: json["SendTo"] as String??"",
      Category: json["Category"] as String??"",
      Depart: json["Depart"] as String??"",
      CompanyName: json["CompanyName"] as String??"",
      Govt: json["Govt"] as String??"",
      image: json["Image"] as String??"",
      video: json["Video"] as String??"",
      mobile: json["Mobile"] as String??"",
      Risky: json["Risky"] as int??1,
      Urgent: json["Urgent"] as int??1,
      Priority: json["Priority"] as int??1,
      Views: json["Views"] as int??1,
    );
  }

}


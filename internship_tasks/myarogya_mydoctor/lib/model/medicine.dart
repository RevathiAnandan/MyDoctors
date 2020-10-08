class Details{
  String days;
  String dosage;
  String duration;
  String medicine;

  Details._({this.days, this.dosage,this.duration,this.medicine});

  factory Details.fromJson(dynamic json) {

    return new Details._(
      days: json['days'] as String,
      dosage: json['dosage'] as String,
      duration: json['duration'] as String,
      medicine: json['medicine'] as String,
    );
  }
}

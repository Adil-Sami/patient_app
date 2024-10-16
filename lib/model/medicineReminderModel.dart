
class MedicineRModel{
  var name;
  var date;
  var time;
  var id;
  var daily;


  MedicineRModel({
    this.name,
    this.date,
    this.time,
    this.id,
    this.daily
  });

  factory MedicineRModel.fromJson(Map<String,dynamic> json){
    return MedicineRModel(
      name: json['name'],
      date: json['date'],
      time: json['time'],
      id: json['id'],
      daily: json['daily']

    );
  }

}
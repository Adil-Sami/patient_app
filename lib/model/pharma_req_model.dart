
class PharmacyReqModel{
  var id;
  var uid;
  var status;
  var imageUrl;
  var pharmaId;
  var createdTimeStamp;
  var desc;


  PharmacyReqModel({
    this.imageUrl,
    this.uid,
    this.id,
    this.status,
    this.pharmaId,
    this.createdTimeStamp,
    this.desc,
  });

  factory PharmacyReqModel.fromJson(Map<String,dynamic> json){
    return PharmacyReqModel(
        uid:json['uid'],
        imageUrl: json['image_url'],
        status: json['status'],
        pharmaId: json['pharma_id'],
        createdTimeStamp:json['created_time_stamp'],
        id: json['id'].toString(),
        desc: json['description'],

    );
  }
  Map<String,dynamic> toJsonUpdate(){
    return {
      "id":this.id,
      "image_url":this.imageUrl,
      "description":this.desc
    };
  }
  Map<String,dynamic> toJsonAdd(){
    return {
      "uid":this.uid,
      "status":this.status,
      "pharma_id":this.pharmaId,
      "image_url":this.imageUrl,
      "description":this.desc

    };

  }
}
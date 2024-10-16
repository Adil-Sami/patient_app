
class UserWalletHistoryModel{
  String? id;
  String? status;
  String? description; //fcm id
  String? amount;
  String? paymentId;
  String? uid;
  String?dateTTime;


  UserWalletHistoryModel({
   this.amount,this.status,
    this.paymentId,
    this.id,
    this.uid,
    this.description,
    this.dateTTime,


  });

  factory UserWalletHistoryModel.fromJson(Map<String,dynamic> json){
    return UserWalletHistoryModel(
       paymentId:json['payment_id'],
      amount:json['amount'],
        status:json['status'],
       id:json['id'],
        uid:json['uid'],
        description:json['description'],
      dateTTime: json['created_time_stamp']

    );
  }

}
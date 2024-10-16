
class TokenModel{
  var tokenNum;
  var tokenType;


  TokenModel({
    this.tokenNum,
    this.tokenType
  });

  factory TokenModel.fromJson(Map<String,dynamic> json){
    return TokenModel(

      tokenNum: json['token_num'],
      tokenType: json['token_type']

    );
  }
  //
  // Map<String, dynamic> toAddJson() {
  //   return {
  //
  //     "name": this.name,
  //     "description": this.description,
  //     "imageUrl": this.imageUrl,
  //
  //   };
  // }
  // Map<String, dynamic> toUpdateJson() {
  //   return {
  //     "name": this.name,
  //     "description": this.description,
  //     "imageUrl": this.imageUrl,
  //     "id":this.id
  //   };
  // }

}
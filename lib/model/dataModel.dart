

class DataModel{

  String? numero;

  DataModel({this.numero});
  factory DataModel.fromJson(Map<String,dynamic> json){
    return DataModel(
      numero:json['numero'],


    );



}
  }
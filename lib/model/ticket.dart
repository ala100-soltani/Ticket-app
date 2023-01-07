

class TicketClient{


  String? postName;
  String? numero;
  String? statusTicket;
  String? date;


TicketClient({this.postName,this.numero,this.statusTicket,this.date});
factory TicketClient.fromJson(Map<dynamic,dynamic> json){
  return TicketClient(


    postName: json['postName'],
    numero: json['numero'],
    statusTicket: json['statusTicket'],
      date: json['date']

  );


}









}


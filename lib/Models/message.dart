class Message
{
  String message;
  String senderid;
  String uniqe;
  DateTime date;

  Message({this.message, this.senderid, this.uniqe, this.date});

  Message.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else {

      message=map['message'];
      senderid=map['senderid'];
      uniqe=map['uniqe'];
      date=map['date'];
    }



  }

  toJson()
  {
    return {
      'message' : message,
      'senderid' : senderid,
      'uniqe':uniqe,
      'date':date,
    };
  }
}
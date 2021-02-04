class Request
{
  String id;
  String time;
  String requesterName;
  DateTime date;
  String status;
  String image;
  String companyname;
  String zipCode;
  String address;
  String location;
  String requestImage;
  Request({this.id,this.time, this.date, this.status , this.image , this.companyname ,this.address , this.location , this.requestImage,this.zipCode , this.requesterName});

  Request.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }else
        {
          id=map['id'];
          time=map['time'];
          date=map['date'];
          status=map['status'];
          image=map['image'];
          companyname=map['companyname'];
          address=map['address'];
          zipCode=map['zipcode'];
          location=map['location'];
          requesterName=map['requestername'];
          requestImage=map['requestimage'];
        }
  }

  toJson()
  {
    return {
      'id':id,
      'time': time,
      'date': date,
      'status': status,
      'image':image,
      'companyname':companyname,
      'address':address,
      'zipcode' : zipCode,
      'location' : location,
      'requestername':requesterName,
      'requestimage':requestImage,
    };
  }
}
class UserModel
{
  String id;
  String name;
  String email;
  String type;

  UserModel({this.id,this.name, this.email, this.type});

  UserModel.fromJson(Map<dynamic,dynamic> map){
    if(map==null)
    {
      return;
    }
    id=map['id'];
    name=map['name'];
    email=map['email'];
    type=map['type'];
  }
  toJson()
  {
    return {
      'id' : id,
      'name' : name,
      'email' :email,
      'type' : type,
    };
  }
}
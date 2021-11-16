class VetModel{
  String?clinicname;
  String?locationLink;
  String?description;
  String?phone;
  String?image;
  String?location;
  String?faceLink;
  String?name;
  String?type;
  String?city;
  String?id;
  String?email;






  VetModel({this.clinicname, this.locationLink, this.description,
      this.phone, this.image, this.location,this.faceLink,this.name,
    this.type,this.city,this.email,this.id});





  toJson(){
    return{
      'DR-Name':name,
      'DR-Phone':phone,
      'DR-Email':email,
      'DR-Id':id,
      'LocationCity':city,
      'ClinicName':clinicname,
      'mapLink':locationLink,
      'faceLink':faceLink,
      'description':description,
      'image':image,
      'type':type,
      'location':location,



    };
  }
}
class PetModel{
  String?name;
  String?color;
  String?birth;
  String?filelink;
  String?price;
  String?image;
  String?weight;
  String?clinicname;
  String?locationLink;
  String?ownername;
  String?owneremail;
  String?ownerlocation;
  String?ownerphone;
  String?ownerid;
  String?vaccinated;
  String?sex;
  String?age;
  String?animaltype;


  PetModel({required this.name,required this.color,required this.birth,required this.filelink,required this.price,required this.sex,
    required  this.image,required this.weight,required this.clinicname,required this.locationLink,
    required  this.ownername,required this.ownerlocation,required this.ownerphone,required this.owneremail,required this.ownerid,
    required this.age,required this.animaltype,required this.vaccinated});

  toJson(){
    return{
      'ownerEmail':owneremail,
      'ownerName':ownername,
      'ownerPhone':ownerphone,
      'ownerLocation':ownerlocation,
      'ClinicName':clinicname,
      'name':name,
      'birthDate':birth,
      'weight':weight,
      'price':price,
      'color':color,
      'mapLink':locationLink,
      'fileLink':filelink,
      'sex':sex,
      'image':image,
      'age':age,
      'type':animaltype,
      'id':ownerid,
      'isVaccinated':vaccinated,

    };
  }


}
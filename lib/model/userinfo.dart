class Userinfo{
  String username;
  String phone;
  String image;
  String id;
  Userinfo({required this.image,required this.phone,required this.username,required this.id});

factory Userinfo.frommap(Map<String,dynamic>data){
  return Userinfo(image: data['img_url'], phone:data['phone_no'], username:data['name'],id:data['id'] );

}
Map<String,dynamic>tomap(){
return{
  'id':id,
  'img_url':image,
  'name':username,
  'phone_no':phone,



};
}

}

class Usermodel{
  final String id;
  final String name;
  final String profilephoto;
   bool isfollowed;
   int  folowcount;

  Usermodel({
    required this.id,required this.name,required this.profilephoto,
    required this.folowcount,
    this.isfollowed=false
  });
}
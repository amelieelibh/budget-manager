class User{
  String id;
  String idEmp;
  String name;
  String pass;
  String role;

  User({String id : "", String idEmp : "", String name : "", String pass : "", String role : "uknown"}){
    this.id = id;
    this.idEmp = idEmp;
    this.name = name;
    this.pass = pass;
    this.role = role;
  }
}
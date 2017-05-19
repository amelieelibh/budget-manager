import 'package:angular2/core.dart';

import 'user.dart';
import 'dart:async';

@Injectable()
class LoginService {
  final List<User> users = [
    new User(id : "admin1",   pass : "pass", role : "admin",  name : "Juan Perez", idEmp : "A0001"),
    new User(id : "man1",     pass : "pass", role : "man",    name : "Gloria Tellez", idEmp : "Z0001"),
    new User(id : "betos",    pass : "pass", role : "x",      name : "Alberto Solis"),
    new User(id : "anapaz",   pass : "pass", role : "x",      name : "Ana Paz"),
    new User(id : "Pedro",    pass : "pass", role : "x",      name : "Pedro Chong"),
    new User(id : "lalo",     pass : "pass", role : "x",      name : "Eduardo Molina"),
    new User(id : "sofias",   pass : "pass", role : "x",      name : "Sofia Suarez"),
    new User(id : "charly",   pass : "pass", role : "x",      name : "Carlos Fuentes"),
    new User(id : "kcruz",    pass : "pass", role : "x",      name : "Karla Cruz"),
    new User(id : "hruiz",    pass : "pass", role : "x",      name : "Héctor Ruiz")
  ];

  Future<User> login(User user) async{
    for(var u in users){
      if(u.id == user.id && u.pass == user.pass){
        user.role = u.role;
        user.pass = "";
        break;
      }
    }
    return user;
  } 
}
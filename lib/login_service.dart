import 'package:angular2/core.dart';

import 'user.dart';
import 'dart:async';

@Injectable()
class LoginService {
  final List<User> users = [
    new User("admin1", "pass", "admin"),
    new User("jefe", "pass", "admin"),
    new User("man1", "pass", "man"),
    new User("contador", "pass", "man"),
    new User("Pedro", "pass", "x"),
    new User("Juan", "pass", "x"),
    new User("Ana", "pass", "x"),
    new User("Jaime", "pass", "x"),
    new User("Elissa", "pass", "x"),
    new User("Amelie", "pass", "x")
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
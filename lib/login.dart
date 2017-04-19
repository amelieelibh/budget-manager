// Copyright (c) 2017, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found loginE file.

import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'globals.dart' as globals;
import 'login_service.dart';
import 'user.dart';
import 'package:modal_dialog/core.dart';

@Component(selector: 'login-view', templateUrl: '../web/login.html',
  providers: const[
    LoginService
  ]
)
class LoginComponent {
  final Router _router;
  final LoginService _loginService;

  LoginComponent(this._router, this._loginService);

  User user = new User("man1", "pass");
  String err = "";

  Future<User> login() async {
    window.console.log("Login:"+this.user.id+","+this.user.pass);
    user = await _loginService.login(this.user);
    globals.user = user;
    if(user.role == "admin"){
      _router.navigate([
        'Admin', 
        {'userid':user.id, 'role':user.role}
      ]);
    }else if(user.role == "man"){
      _router.navigate([
        'Manager', 
        {'userid':user.id, 'role':user.role}
      ]);
    }else{
      Element dvMsg = querySelector('#errmsg');
      err = "El usuario o la contraseña no son válidos";
      dvMsg.style.visibility="";
      
      /*ModalAlert errMsg = new ModalAlert(
        "Falló Inicio de Sesión", "El usuario o la contraseña no son válidos",
        accept: (ModalDialog dialog){
          dialog.close();
        });
      errMsg.open();*/
    }
    return user;
  }
}
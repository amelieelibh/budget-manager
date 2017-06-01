// Copyright (c) 2017, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found loginE file.

import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular_components/angular_components.dart';

import 'globals.dart' as globals;
import 'login_service.dart';
import 'user.dart';

@Component(selector: 'login-view', templateUrl: '../web/login.html',
  directives: const[
    NgModel,
    CORE_DIRECTIVES,
    GlyphComponent,
    MaterialButtonComponent,
    MaterialFabComponent,
    MaterialInputComponent,
    MaterialInputDefaultValueAccessor,
  ],
  providers: const[
    LoginService
  ],
)
class LoginComponent implements OnInit{
  final Router _router;
  final LoginService _loginService;

  LoginComponent(this._router, this._loginService);
  
  String err = "";
  User user = globals.user;
  
  @override
  Future<Null> ngOnInit() async {
    globals.user = new User(id : "man1", pass:"pass");
    user = globals.user;
  }

  Future<Null> login() async { 
    window.console.log("Login:" + globals.user.id + "," + globals.user.pass);
    globals.user = await _loginService.login(user);
    
    if(globals.user.role == "admin"){
      _router.navigate([
        'Admin',
        {'userid' : globals.user.id}
      ]);
    }else if(globals.user.role == "man"){
      _router.navigate([
        'Manager',
        {'userid' : globals.user.id}
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
    //return user;
  }

  void onKey(dynamic  event) {
    KeyEvent keyEvent = new KeyEvent.wrap(event);
    if (keyEvent.keyCode == KeyCode.ENTER) {
      login();
    }
  }
}
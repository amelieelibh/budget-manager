//import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'not_found_component.dart';

import 'login.dart';
import 'admin.dart';
import 'manager.dart';
import 'folio_detail.dart';

@Component(selector: 'my-app', 
  template: '''
    <router-outlet></router-outlet>
    <router-outlet name="s"></router-outlet>
    <router-outlet name="popup"></router-outlet>
  ''',
  directives: const[ROUTER_DIRECTIVES],
  providers: const [ROUTER_PROVIDERS]
)
@RouteConfig(const[
  const Redirect(path: '/', redirectTo: const['Login']),
  const Route(path: '/login', name: 'Login', component: LoginComponent),
  const Route(path: '/sysadmin/:userid', name: "Admin", component: AdminComponent),
  const Route(path: '/manager/:userid', name: "Manager", component: ManagerComponent),
  const Route(path: '/folio-detail', name: 'FolioDetail', component: FolioDetailComponent),
  const Route(path: '/**', name: 'NotFound', component: NotFoundComponent)
])
class AppComponent {
}
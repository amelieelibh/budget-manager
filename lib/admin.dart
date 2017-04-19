import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
  selector: "manager-view",
  templateUrl: '../web/admin.html'
)
class AdminComponent implements OnInit{
  final Router _router;
  final RouteParams _routeParams;
  var userid = null;

  AdminComponent(this._router, this._routeParams);

  Future<Null> ngOnInit() async {
    userid = _routeParams.get('userid');
  }

  Future goBack() => _router.navigate(['Login']);
}
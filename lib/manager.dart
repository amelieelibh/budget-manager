import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'folios_service.dart';
import 'folio.dart';
import 'upload_service.dart';

@Component(
  selector: "manager-view",
  templateUrl: '../web/manager.html',
  providers: const [
    FoliosService
  ]
)
class ManagerComponent implements OnInit{
  final Router _router;
  final RouteParams _routeParams;
  final FoliosService _foliosService;

  var userid = null;
  List<Folio> folios;
  Folio selectedFolio = null;

  ManagerComponent(this._router, this._routeParams, this._foliosService);

  Future<Null> ngOnInit() async {
    userid = _routeParams.get('userid');
    folios = await _foliosService.getFolios(userid);
  }

  void onSelect(Folio folio) {
    selectedFolio = folio;
    //window.alert(folio.folio+","+folio.nombreProyecto);
    gotoDetail(folio);
  }

  Future gotoDetail(Folio folio) =>
    _router.navigate([
        'FolioDetail',{'folio': folio}
    ]);
  

  Future goBack() => _router.navigate(['Login']);


  Future addFolio() {
    
  }

}
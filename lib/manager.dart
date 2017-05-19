import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'user.dart';
import 'globals.dart' as globals;
import 'folios_service.dart';
import 'folio.dart';
import 'upload_service.dart';
import 'package:modal_dialog/core.dart';
import 'package:observable/observable.dart';

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
  final ApplicationRef _appRef;

  ObservableList<Folio> folios = toObservable(new List());
  Folio selectedFolio = null;
  User user = new User();

  ManagerComponent(this._router, this._routeParams, this._foliosService, this._appRef);

  Future<Null> ngOnInit() async {
    user = globals.user;
    var f = await _foliosService.getFolios(user.id);
    if(f != null && !f.isEmpty){
      globals.user.idEmp = f[0].idResponsable;
      //globals.user.name = f[0].nombreResponsable;
    }
    folios.addAll(f);
  }

  void onSelect(Folio folio) {
    selectedFolio = folio;
    //window.alert(folio.folio+","+folio.nombreProyecto);
    gotoDetail(folio);
  }

  Future gotoDetail(Folio folio){
    globals.folio = folio;
    _router.navigate([
        'FolioDetail'
    ]);
  }

  Future goBack() => _router.navigate(['Login']);


  Future addFolio(String folio, String proyecto, String idResp) {
    var f = new Folio(folio, proyecto, idResp);
    folios.add(f);
    _appRef.tick();
    window.console.debug(folios.toString());
  }
  Future createFolio(){
    String htmlContent = """
      <h3>Completa la información del nuevo folio</h3>
      <form id="new-folio-form" action="#" class="form-horizontal">
        <div class="form-group">
          <label class="control-label" for="inFolio">Folio:</label>
          <input id="inFolio"
              type="text" class="form-control" required
              placeholder="Folio del proyecto" />
        </div>
        <div class="form-group">
          <label class="control-label" for="inNombreProyecto">Proyecto:</label>
          <input id="inNombreProyecto"
              type="text" class="form-control" required
              placeholder="Nombre del proyecto" />
          <br/>
        </div>
      </form>
      """;
    var modal = new ModalConfirm("Nuevo Folio", htmlContent,
      html: true, acceptLabel: "Agregar", cancelLabel: "Cancelar", accept: (ModalDialog modal){
        String folio = (querySelector("#inFolio") as InputElement).value;
        String proy = (querySelector("#inNombreProyecto") as InputElement).value;
        addFolio(folio, proy, globals.user.idEmp);
        modal.close();
      })
      ..open();
      modal.modal.element.classes.add("budget-modal");
      querySelector(".modal-dialog").style.margin = "auto";
  }

}
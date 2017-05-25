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
    gotoDetail(folio);
  }

  Future gotoDetail(Folio folio){
    globals.folio = folio;
    _router.navigate([
        'FolioDetail'
    ]);
  }

  Future goBack() => _router.navigate(['Login']);


  Future addFolio(String folio, String idCC, String cc, String idResp,
        String desc, double mount) {
    var f = new Folio(folio : folio, centroCostos : cc, idResponsable : idResp,
        cc : idCC, descripcion : desc, monto : mount);
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
          <label class="control-label" for="inCC">CC:</label>
          <input id="inCC"
              type="text" class="form-control" required
              placeholder="Id del centro de Costos" />
          <br/>
        </div>
        <div class="form-group">
          <label class="control-label" for="inCentroCostos">Centro de Costos:</label>
          <input id="inCentroCostos"
              type="text" class="form-control" required
              placeholder="Centro de Costos" />
          <br/>
        </div>
        <div class="form-group">
          <label class="control-label" for="inDescripcion">Descrici&oacute;n:</label>
          <input id="inDescripcion"
              type="text" class="form-control" required
              placeholder="Descripción corta del proyecto" />
          <br/>
        </div>
        <div class="form-group">
          <label class="control-label" for="inMonto">Monto:</label>
          <input id="inMonto"
              type="number" step="0.01" class="form-control" required
              placeholder="Descripción corta del proyecto" />
          <br/>
        </div>
      </form>
      """;
    var modal = new ModalConfirm("Nuevo Folio", htmlContent,
      html: true, acceptLabel: "Agregar", cancelLabel: "Cancelar", accept: (ModalDialog modal){
        String folio = (querySelector("#inFolio") as InputElement).value;
        String idCC = (querySelector("#inCC") as InputElement).value;
        String centroCostos = (querySelector("#inCentroCostos") as InputElement).value;
        String desc = (querySelector("#inDescripcion") as InputElement).value;
        double monto = double.parse((querySelector("#inMonto") as InputElement).value);
        addFolio(folio, idCC, centroCostos, globals.user.idEmp, desc, monto);
        modal.close();
      })
      ..open();
      modal.modal.element.classes.add("budget-modal");
      querySelector(".modal-dialog").style.margin = "auto";
  }

}
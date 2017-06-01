import 'dart:html';
import 'dart:async';
//import 'package:angular2/core.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular_components/angular_components.dart';

import 'user.dart';
import 'globals.dart' as globals;
import 'folios_service.dart';
import 'folio.dart';
import 'package:observable/observable.dart';

@Component(
  selector: "manager-view",
  templateUrl: '../web/manager.html',
  providers: const [
    FoliosService,
    popupBindings,
  ],
  directives: const[
    NgModel,
    CORE_DIRECTIVES,
    GlyphComponent,
    MaterialButtonComponent,
    MaterialFabComponent,
    MaterialInputComponent,
    MaterialInputDefaultValueAccessor,
    AutoFocusDirective,
    MaterialDialogComponent,
    ModalComponent,
  ]
)
class ManagerComponent implements OnInit{
  final Router _router;
  final FoliosService _foliosService;
  final ApplicationRef _appRef;

  ObservableList<Folio> folios = toObservable(new List());
  Folio selectedFolio = null;
  User user = new User();
  bool showNewFolioForm = false;
  Folio newFolio = new Folio();

  ManagerComponent(this._router, this._foliosService, this._appRef);

  Future<Null> ngOnInit() async {
    user = globals.user;
    var f = await _foliosService.getFolios(user.id);
    if(f != null && !f.isEmpty){
      globals.user.idEmp = f[0].idResponsable;
      newFolio.idResponsable = globals.user.idEmp;
    }
    folios.addAll(f);
  }

  void onSelect(Folio folio) {
    selectedFolio = folio;
    gotoDetail(folio);
  }

  void gotoDetail(Folio folio){
    globals.folio = folio;
    _router.navigate([
        'FolioDetail'
    ]);
  }

  Future goBack() => _router.navigate(['Login']);

  void addFolio(bool confirm) {
    //window.alert(""+newFolio.idResponsable);
    if(confirm){
      folios.add(newFolio);
    }
    newFolio = new Folio(idResponsable: globals.user.idEmp);
    _appRef.tick();
    window.console.debug(folios.toString());
    showNewFolioForm = false;
  }

}
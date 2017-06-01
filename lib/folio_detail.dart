import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular2/angular2.dart';

import 'globals.dart' as globals;
import 'bills_service.dart';
import 'bill.dart';
import 'constants.dart';
import 'user.dart';
import 'folio.dart';
import 'package:observable/observable.dart';

@Component(
  selector: "manager-view",
  templateUrl: '../web/folio-detail.html',
  providers: const[
    BillsService,
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
  ],
)
class FolioDetailComponent implements OnInit{
  final Router _router;
  final RouteParams _routeParams;
  final BillsService _billsService;
  final ApplicationRef _appRef;

  FolioDetailComponent(this._router, this._routeParams, this._billsService, this._appRef);
  
  Folio folio = new Folio();
  ObservableList<Bill> bills = toObservable(new List());
  User user = new User();
  var i = 0;
  bool showNewBillForm = false;
  bool showSavePopup = false;
  bool showSavedPopup = false;
  Bill newBill = new Bill();

  void updateTableView(String i, bool isEditable){
    var editable = isEditable ? "true" : "false";
    querySelector("#"+BudgetConstants.divAcc+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#"+BudgetConstants.divMount+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#"+BudgetConstants.divCfdi+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#"+BudgetConstants.divDesc+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    //querySelector("#"+BudgetConstants.divEid+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    //querySelector("#"+BudgetConstants.divEname+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#"+BudgetConstants.divRfc+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    
    querySelector("#"+BudgetConstants.butEdit+i).style.visibility=isEditable ? "hidden" : "";
    querySelector("#"+BudgetConstants.butEditOk+i).style.visibility=isEditable ? "" : "hidden";
    //querySelector("#"+BudgetConstants.butEditCancel+i).style.visibility="";
    
    if(isEditable)
      querySelector("#row"+i).classes.add("selected");
    else
      querySelector("#row"+i).classes.remove("selected");
  }
  void showDetail(String i, bool show){
    String toggleClass = show ? "glyphicon-zoom-out" : "glyphicon-zoom-in";
    querySelector("#"+BudgetConstants.butDetail+i).classes
      ..remove("glyphicon-zoom-in")..remove("glyphicon-zoom-out")
      ..add(toggleClass);
  }
  void onEditRow(MouseEvent event){
    Element e = event.target;
    var i = e.getAttribute("name");
    updateTableView(i, true);
  }
  void onEditOkRow(MouseEvent event){
    Element e = event.target;
    var i = e.getAttribute("name");
    updateTableView(i, false);
  }
  void onShowDetail(MouseEvent event){
    Element e = event.target;
    var i = e.getAttribute("name");
    bool show = e.classes.contains("glyphicon-zoom-in");
    showDetail(i, show);
  }
  void uploadCfdi(var i){
    //Element e = event.target;
    //var i = e.getAttribute("name");
    //window.alert("upload"+i.toString());
    //querySelector("#upload"+i.toString()).click();
  }

  String get divAcc => BudgetConstants.divAcc;
  String get divCfdi => BudgetConstants.divCfdi;
  String get divDesc => BudgetConstants.divDesc;
  String get divEid => BudgetConstants.divEid;
  String get divEname => BudgetConstants.divEname;
  String get divMount => BudgetConstants.divMount;
  String get divRfc => BudgetConstants.divRfc;
  String get butEdit => BudgetConstants.butEdit;
  String get butEditOk => BudgetConstants.butEditOk;
  String get butDetail => BudgetConstants.butDetail;
  String get butUploadCfdi => BudgetConstants.butUploadCfdi;
  
  Future<Null> toggleCollapse(var i) async { 
    //window.alert("hola"+i.toString());
    querySelector("#details"+i.toString()).classes.toggle("collapse");
  }

  Future<Null> ngOnInit() async {
    folio = globals.folio;
    user = globals.user;
    var b = await _billsService.getBills(folio.folio);
    bills.addAll(b);
  }

  Future goBack() { 
    globals.folio = Folio.EMPTY();
    _router.navigate([
        'Manager',
        {'userid' : globals.user.id}
      ]
    );
  }

  Future<bool> saveChanges() async {
     List<Bill> modified = [];
     bool r = await _billsService.saveDetails(modified);
     if(r){
       ModalConfirm dialog = new ModalConfirm('Guardar la Información',
        '¿Esta seguro que desea guardar la información?',
        acceptLabel: "Sí", cancelLabel: "No",
          accept: (ModalDialog dialog) {
            ModalAlert modalAlert = new ModalAlert("Guardado Exitoso",
             'Su información se ha guardado', acceptLabel: "Aceptar")
              ..modal.element.style.left = "50%" 
              ..modal.element.style.top = "50%" 
              ..open();
            dialog.close();
        });
      dialog
      ..modal.element.style.left = "50%" 
      ..modal.element.style.top = "50%" 
      ..open();
     }else{
       window.console.log("not saved");
     }
     return r;
  }

  Future uploadFiles(var i){
    var mm = new ModalMessage("Carga de Archivos", "Archivos Cargados")
      ..modal.element.style.left = "50%"
      ..modal.element.style.top = "50%"
      ..open();
    new Future.delayed(const Duration(milliseconds: 1500), ()=> mm.close());
  }

  Future addBill(String contableAccount, num mount, String rfc,
        String desc, String cfdi, Map<String, String> employees){
    var b = new Bill(contableAccount, mount, rfc, desc: desc, 
        cfdi: cfdi, employees: employees);
    bills.add(b);
    addRowBill(null, null, false, b);
    _appRef.tick();
    window.console.debug(bills.toString());
  }
  Future createBill(){
    String htmlContent = """
      
      """;
    new ModalConfirm("Agregar Nuevo Gasto", htmlContent,
      html: true, acceptLabel: "Agregar", cancelLabel: "Cancelar", accept: (ModalDialog modal){
        String cta = (querySelector("#inCta") as InputElement).value;
        num mount = num.parse((querySelector("#inMount") as InputElement).value);
        String rfc = (querySelector("#inRfc") as InputElement).value;
        String desc = (querySelector("#inDesc") as InputElement).value;
        addBill(cta, mount, rfc, desc, "", {});
        modal.close();
      })
      ..open()
      ..modal.element.classes.add("budget-modal");
      querySelector(".modal-dialog").style.margin = "auto";
  }
  void addEmployeeRow(){
    var table = querySelector("tblForEmployees") as TableElement;
    /*var row = table.insertRow(-1);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    cell1.innerHTML = "-";
    cell2.innerHTML = "-";*/
  }
  void addRowBill(bool confirm){
      if(tBody == null){
        tBody = querySelector("tbody") as TableSectionElement;
      }
      if(i == null){
        var index = tBody.children.length;
        i = ((index ~/ 2) + 1).toString();
      }
      String isEditable = editable.toString();
      var newLine = tBody.addRow()..id = "row"+i;

      DivElement index = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)..text = i;
      DivElement acc = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divAcc+i.toString())..text = b.contableAccount;
      DivElement mount = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divMount+i.toString())..text = b.mount.toStringAsFixed(2);
      DivElement rfc = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divRfc+i.toString())..text = b.rfc;
      
      DivElement cfdi = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divCfdi+i.toString());
      DivElement desc = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divDesc+i.toString())..text = b.desc;
      
      var butEdit = new SpanElement()..classes.addAll(["glyphicon","glyphicon-pencil"])
        ..setAttribute("id", BudgetConstants.butEdit+i.toString())
        ..setAttribute("name", i.toString())
        ..style.visibility=""
        ..onClick.listen((MouseEvent event) => onEditRow(event));
      var butOkEdit = new SpanElement()..classes.addAll(["glyphicon","glyphicon-ok"])
        ..setAttribute("id", BudgetConstants.butEditOk+i.toString())
        ..setAttribute("name", i.toString())..style.visibility="hidden"
        ..onClick.listen((MouseEvent event) => onEditOkRow(event));
      var butDetail = new SpanElement()..classes.addAll(["glyphicon","glyphicon-zoom-in"])
        ..setAttribute("id", BudgetConstants.butDetail+i.toString())
        ..setAttribute("name", i.toString())
        ..setAttribute("data-toggle", "collapse")
        ..setAttribute("data-target", "#details"+i.toString())
        ..onClick.listen((MouseEvent event) => onShowDetail(event));
      

      var butUploadCfdi = new LabelElement()
        ..htmlFor = "upload"+i.toString()
        ..children.addAll([
          new SpanElement()..classes.addAll(["glyphicon","glyphicon-upload"])
            ..setAttribute("id", BudgetConstants.butUploadCfdi+i.toString())
            ..setAttribute("name", i.toString())
            ..onClick.listen((MouseEvent event) => uploadCfdi(event))
          , new InputElement()..type = "file"
            ..id = "upload" + i.toString()
            ..name = "files[]" ..style.display = "none"
            ..onChange.listen((event)=> uploadFiles(event))
        ]);
      var butDownloadCfdi = new AnchorElement()..href = b.cfdi
        ..children.add(
          new SpanElement()..classes.addAll(["glyphicon","glyphicon-download-alt"])
            ..setAttribute("id", BudgetConstants.butDownloadCfdi+i.toString())
            ..setAttribute("name", i.toString())..style.visibility=(b.cfdi != null && !b.cfdi.isEmpty ? "" : "hidden")
        )..target = "_blank";
      cfdi.children.addAll([butUploadCfdi, butDownloadCfdi]);
      

      newLine
      ..addCell().children.addAll([butEdit, butOkEdit])
      ..addCell().children.add(index)
      ..addCell().children.add(acc)
      ..addCell().children.add(mount)
      ..addCell().children.add(rfc)
      ..addCell().children.add(cfdi)
      ..addCell().children.add(desc)
      //newLine.addCell().children.add(empId);
      //newLine.addCell().children.add(empName);
      ..addCell().children.add(butDetail)
      ;
      butDetail.parent.style.textAlign="center";

      var newDetails = tBody.addRow()
        ..id = "details"+i.toString()
        ..classes.add("collapse");
      

      Element detailsElem = new Element.ul();
      for(String key in b.employees.keys){
        Element rowDet = new Element.li();
        rowDet.appendHtml('<span class="badge">' + key + '</span> <span> ' + b.employees[key] + ' </span>');
        detailsElem.children.add(rowDet);
      }

      var cellDetails = newDetails.addCell();
      cellDetails
        ..children.add(detailsElem)
        ..colSpan=7
      ;
      
    }
}
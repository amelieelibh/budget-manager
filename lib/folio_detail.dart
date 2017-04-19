import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';

import 'globals.dart' as globals;
import 'bills_service.dart';
import 'bill.dart';
import 'constants.dart';
import 'user.dart';
import 'folio.dart';
import 'package:modal_dialog/core.dart';

@Component(
  selector: "manager-view",
  templateUrl: '../web/folio-detail.html',
  providers: const[
    BillsService
  ]
)
class FolioDetailComponent implements OnInit{
  final Router _router;
  final RouteParams _routeParams;
  final BillsService _billsService;

  FolioDetailComponent(this._router, this._routeParams, this._billsService);
  
  Folio folio = new Folio("", "", "", "");
  List<Bill> bills = [];
  User user;
  

  void updateTableView(String i, bool isEditable){
    var editable = isEditable ? "true" : "false";
    querySelector("#"+BudgetConstants.divAcc+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#"+BudgetConstants.divCfdi+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#"+BudgetConstants.divDesc+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    //querySelector("#"+BudgetConstants.divEid+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    //uerySelector("#"+BudgetConstants.divEname+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
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
  void uploadCfdi(MouseEvent event){
    Element e = event.target;
    var i = e.getAttribute("name");
    
  }

  Future<Null> ngOnInit() async {
    folio = _routeParams.get('folio');
    
    user = globals.user;
    bills = await _billsService.getBills(folio);

    TableElement table = new TableElement();
    table.classes..add("pure-table")..add("pure-table-horizontal");

    table.createTHead().insertRow(-1).nodes
      ..add(new Element.th()..text = "")
      ..add(new Element.th()..text = "#")
      ..add(new Element.th()..text = "Cta Contable")
      ..add(new Element.th()..text = "RFC proveedor")
      ..add(new Element.th()..text = "CFDI")
      ..add(new Element.th()..text = "Descripción")
      //..nodes.add(new Element.tag('th')..text = "Id del Empleado")
      //..nodes.add(new Element.tag('th')..text = "Nombre del Empleado")
      ..add(new Element.th()..text = "Detalle")
      ;
    
    
    var isEditable = "false";
    var tBody = table.createTBody();
    int i = 0;
    for(var b in bills){
      i++;
      var newLine = tBody.addRow()..id = "row"+i.toString();

      DivElement index = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)..text = i.toString();
      DivElement acc = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divAcc+i.toString())..text = b.contableAccount;
      DivElement rfc = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divRfc+i.toString())..text = b.rfc;
      
      DivElement cfdi = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divCfdi+i.toString());
      DivElement desc = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        ..setAttribute("id",BudgetConstants.divDesc+i.toString())..text = b.desc;
      //DivElement empId = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        //..setAttribute("id",BudgetConstants.divEid+i.toString())..text = b.employeeId;
      //DivElement empName = new DivElement()..setAttribute(BudgetConstants.EDITABLE_ATTR, isEditable)
        //..setAttribute("id",BudgetConstants.divEname+i.toString())..text = b.empName;
      
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
      for(var item in b.employees){
        Element rowDet = new Element.li();
        detailsElem.children.add(rowDet);
      }

      var cellDetails = newDetails.addCell();
      cellDetails
        ..children.add(detailsElem)
        ..colSpan=6
      ;
      
    }

    Element dvBudget = querySelector('#budget');
    dvBudget.children.add(table);
  }

  Future goBack() => _router.navigate([
        'Manager', 
        {'userid':user.id, 'role':user.role}
      ]);

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
              ..modal.element.style.left = "auto" 
              ..modal.element.style.top = "auto" 
              ..open();
            dialog.close();
        });
      dialog
      ..modal.element.style.left = "auto" 
      ..modal.element.style.top = "auto" 
      ..modal.element.style.bottom = "auto"
      ..open();
     }else{
       window.console.log("not saved");
     }
     return r;
  }

  Future uploadFiles(Event event){
    var mm = new ModalMessage("Carga de Archivos", "Archivos Cargados")
      ..modal.element.style.left = "auto"
      ..modal.element.style.top = "auto"
      ..modal.element.style.bottom = "auto"
      ..open();
    new Future.delayed(const Duration(milliseconds: 1500), ()=> mm.close());
  }

  Future addBill(){

  }
}
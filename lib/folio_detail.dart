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
  providers: const [
    BillsService,
    popupBindings,
  ],
  directives: const [
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
    MaterialToggleComponent,
  ],
)
class FolioDetailComponent implements OnInit {
  final Router _router;
  final BillsService _billsService;
  final ApplicationRef _appRef;

  FolioDetailComponent(
      this._router, this._billsService, this._appRef);

  Folio folio = new Folio();
  ObservableList<Bill> bills = toObservable(new List());
  User user = new User();
  var i = 0;
  bool showNewBillForm = false;
  bool showSaveDialog = false;
  bool showSavedDialog = false;
  bool showNotSavedDialog = false;
  bool showFilesUploadedDialog = false;
  Bill newBill = new Bill();
  bool showEmps = false;

  void showNewBillFormView(){
    showNewBillForm = true;
    (querySelector('#inMount input') as InputElement).type = 'number';
  }

  void updateTableView(String i, bool isEditable) {
    var editable = isEditable.toString();;// ? "true" : "false";
    querySelector("#" + BudgetConstants.divAcc + i)
        .setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#" + BudgetConstants.divMount + i)
        .setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#" + BudgetConstants.divCfdi + i)
        .setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#" + BudgetConstants.divDesc + i)
        .setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    //querySelector("#"+BudgetConstants.divEid+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    //querySelector("#"+BudgetConstants.divEname+i).setAttribute(BudgetConstants.EDITABLE_ATTR, editable);
    querySelector("#" + BudgetConstants.divRfc + i)
        .setAttribute(BudgetConstants.EDITABLE_ATTR, editable);

    querySelector("#" + BudgetConstants.butEdit + i).hidden = isEditable;
    querySelector("#" + BudgetConstants.butEditOk + i).hidden = !isEditable;
    //querySelector("#"+BudgetConstants.butEditCancel+i).style.visibility="";

    /*if (isEditable)
      querySelector("#row" + i).classes.add("selected");
    else
      querySelector("#row" + i).classes.remove("selected");
  }*/

  void showDetail(String i, bool show) {
    String toggleClass = show ? "glyphicon-zoom-out" : "glyphicon-zoom-in";
    querySelector("#" + BudgetConstants.butDetail + i).classes
      ..remove("glyphicon-zoom-in")
      ..remove("glyphicon-zoom-out")
      ..add(toggleClass);
  }

  void onEditRow(var i) {
    updateTableView((i+1).toString(), true);
  }

  void onEditOkRow(var i) {
    updateTableView((i+1).toString(), false);
  }

  void onShowDetail(MouseEvent event) {
    Element e = event.target;
    var i = e.getAttribute("name");
    bool show = e.classes.contains("glyphicon-zoom-in");
    showDetail(i, show);
  }

  void uploadCfdi(var i) {
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

  void toggleCollapse(var i) {
    //window.alert("hola"+i.toString());
    querySelector("#details" + i.toString()).classes.toggle("collapse");
  }

  Future<Null> ngOnInit() async {
    folio = globals.folio;
    user = globals.user;
    var b = await _billsService.getBills(folio.folio);
    bills.addAll(b);
  }

  Future<Null> goBack() async {
    globals.folio = Folio.EMPTY();
    _router.navigate([
      'Manager',
      {'userid': globals.user.id}
    ]);
  }

  Future<bool> saveChanges() async {
    showSavedDialog = true;
    bool r = await _billsService.saveDetails([]);
    if (r) {
      showSavedDialog = true;
    } else {
      window.console.log("not saved");
      showNotSavedDialog = true;
    }
    showSaveDialog = false;
    return r;
  }

  Future uploadFiles(var i) {
    showFilesUploadedDialog = true;
    new Future.delayed(const Duration(milliseconds: 1500), () => showFilesUploadedDialog = false);
  }

  void addEmployeeRow() {
    var table = querySelector("#tblForEmployees") as TableElement;
    var row = table.addRow();
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    cell1
      ..contentEditable = "true"
      ..innerHtml = " ";
    cell2
      ..contentEditable = "true"
      ..innerHtml = " ";
  }

  void addRowBill(bool confirm) {
    showNewBillForm = false;
    if(confirm){
      bills.add(newBill);
    }
    newBill = new Bill();
  }

}
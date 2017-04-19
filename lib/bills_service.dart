import 'package:angular2/core.dart';

import 'dart:async';
import 'bill.dart';

@Injectable()
class BillsService {
  final List<Bill> bills = [
    new Bill('diseñoImagen9836', 'PALHIERRO07', 'maquillaje', '', {'id': 'Emp01', 'name':'Pedro Fuentes'}),
    new Bill('diseñoImagen9836', 'PALHIERRO07', 'corte y peinado', '', {'id':'Emp01', 'name':'Carlos Robles'}),
    new Bill('diseñoImagen9836', 'PALHIERRO07', 'accesorios', 'http://www.patito.com/cfdi3', {'id':'Emp01', 'name':'Pedro Fuentes'})
  ];

  Future<List<Bill>> getBills(String folio) async{
    return bills;
  } 

  Future<bool> saveDetails(List<Bill> bills) async{
    return true;
  } 
}
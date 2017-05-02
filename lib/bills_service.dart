import 'package:angular2/core.dart';

import 'dart:async';
import 'bill.dart';

@Injectable()
class BillsService {
  final List<Bill> bills = [
    new Bill('diseñoImagen9836', 1000.80, 'PALHIERRO07', desc:'maquillaje', employees:{'Emp01' :'Pedro Fuentes'}),
    new Bill('diseñoImagen9836', 1350.00, 'PALHIERRO07', desc:'corte y peinado', employees:{'id':'Emp01', 'name':'Carlos Robles'}),
    new Bill('diseñoImagen9836', 356.10, 'PALHIERRO07', desc:'accesorios', cfdi:'http://www.patito.com/cfdi3', employees:{'id':'Emp01', 'name':'Pedro Fuentes'})
  ];

  Future<List<Bill>> getBills(String folio) async{
    return bills;
  } 

  Future<bool> saveDetails(List<Bill> bills) async{
    return true;
  } 
}
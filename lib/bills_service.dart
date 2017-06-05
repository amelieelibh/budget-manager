import 'package:angular2/core.dart';

import 'dart:async';
import 'bill.dart';

@Injectable()
class BillsService {
  final List<Bill> bills = [
    new Bill(contableAccount:'diseñoImagen9836', mount:1000.80, rfc:'PALHIERRO07', desc:'maquillaje', employees:{'Emp01' :'Pedro Fuentes'}),
    new Bill(contableAccount:'diseñoImagen9836', mount:1350.00, rfc:'PALHIERRO07', desc:'corte y peinado', employees:{'Emp02':'Carlos Robles'}),
    new Bill(contableAccount:'diseñoImagen9836', mount:356.10, rfc:'PALHIERRO07', desc:'accesorios', cfdi:'resources/cfdi-prueba.xml', employees:{'Emp01':'Pedro Fuentes', 'Emp03':'Pepe Pecas'})
  ];

  Future<List<Bill>> getBills(String folio) async{
    return bills;
  } 

  Future<bool> saveDetails(List<Bill> bills) async{
    return true;
  } 
}
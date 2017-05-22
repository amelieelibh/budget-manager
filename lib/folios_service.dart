import 'package:angular2/core.dart';

import 'folio.dart';
import 'dart:async';

@Injectable()
class FoliosService {
  final List<Folio> folios = [
    new Folio(folio:"00001", cc:"02275", idResponsable:"A0001", centroCostos:"Lo que callamos las mujeres", descripcion:"Viaje Acapulco", monto:5000.00, check:true),
    new Folio(folio:"00020", cc:"31402", idResponsable:"A0001", centroCostos:"Lo que callamos las mujeres", descripcion:"Opening", monto:45000.00, check:false),
    new Folio(folio:"04000", cc:"85420", idResponsable:"A0001", centroCostos:"La Fiscal de Hierro", descripcion:"Promocionales", monto:6500.00, check:false),
    new Folio(folio:"50001", cc:"31402", idResponsable:"A0001", centroCostos:"La Fiscal de Hierro", descripcion:"Opening", monto:55000.00, check:false),
    new Folio(folio:"60701", cc:"85420", idResponsable:"A0001", centroCostos:"Nada Personal", descripcion:"Promocionales", monto:8000.00, check:false),
    new Folio(folio:"89015", cc:"02275", idResponsable:"A0001", centroCostos:"Nada Personal", descripcion:"Viaje Queretaro", monto:15000.00, check:false),
    new Folio(folio:"99990", cc:"55055", idResponsable:"A0001", centroCostos:"La Academia", descripcion:"Publicidad", monto:29000.50, check:false),
  ];

  Future<List<Folio>> getFolios(String userid) async{
    return folios;
  } 

}
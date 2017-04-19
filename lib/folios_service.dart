import 'package:angular2/core.dart';

import 'folio.dart';
import 'dart:async';

@Injectable()
class FoliosService {
  final List<Folio> folios = [
    new Folio("00001", "Novela Personajes", "A0001", "Juan Perez Perez"),
    new Folio("00020", "Comercial OneShot", "A0001", "Juan Perez Perez"),
    new Folio("00300", "Reportaje de la 1", "A0001", "Juan Perez Perez"),
    new Folio("04000", "Reportaje de las 8", "A0001", "Juan Perez Perez"),
    new Folio("50000", "Entrevista ciudadana", "A0001", "Juan Perez Perez"),
    new Folio("60701", "Tour de la Academia", "A0001", "Juan Perez Perez"),
    new Folio("89015", "La Academia", "A1000", "Juan Perez Perez"),
    new Folio("99990", "Publicidad", "A10000", "Juan Perez Perez")
  ];

  Future<List<Folio>> getFolios(String userid) async{
    return folios;
  } 

}
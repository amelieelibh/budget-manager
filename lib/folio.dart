class Folio{
  String folio;
  String idResponsable;
  String cc;
  String centroCostos;
  String descripcion;
  double monto;
  bool check;

  Folio({String folio : "", String idResponsable : "", String cc : "",  
      String centroCostos : "", String descripcion : "", double monto : 0.00, 
      bool check : false}){
    this.folio = folio;
    this.idResponsable = idResponsable;
    this.cc = cc;
    this.centroCostos = centroCostos;
    this.descripcion = descripcion;
    this.monto = monto;
    this.check = check;
  }

  bool isFilled(){
    return !folio.isEmpty && !idResponsable.isEmpty
        && !cc.isEmpty && monto > 0.0;
  }
  void clear(){
    this.folio = "";
    this.idResponsable = "";
    this.cc = "";
    this.centroCostos = "";
    this.descripcion = "";
    this.monto = 0.0;
    this.check = false;
  }
  
  @override
  String toString(){
    return "folio:" + folio 
    + " idResponsable:" + idResponsable
    + " cc:" + cc
    + " centroCostos:" + centroCostos
    + " descripcion:" + descripcion
    + " monto:" + monto.toString()
    + " check:" + check.toString();
  }

  static Folio EMPTY(){
    return new Folio();
  }
}
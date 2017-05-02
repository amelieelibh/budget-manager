class Folio{
  String folio;
  String nombreProyecto;
  String idResponsable;
  String nombreResponsable;
  

  Folio(this.folio, this.nombreProyecto, this.idResponsable, this.nombreResponsable);
  
  @override
  String toString(){
    return "folio:" + folio 
    + " nombreProyecto:" + nombreProyecto
    + " idResponsable:" + idResponsable 
    + " nombreResponsable:" + nombreResponsable;
  }

  static Folio EMPTY(){
    return new Folio("", "", "", "");
  }
}
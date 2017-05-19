class Folio{
  String folio;
  String nombreProyecto;
  String idResponsable;
  

  Folio(this.folio, this.nombreProyecto, this.idResponsable);
  
  @override
  String toString(){
    return "folio:" + folio 
    + " nombreProyecto:" + nombreProyecto
    + " idResponsable:" + idResponsable;
  }

  static Folio EMPTY(){
    return new Folio("", "", "");
  }
}
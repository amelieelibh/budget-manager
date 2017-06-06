class Bill {
  String contableAccount;
  num mount;
  String rfc;
  String desc;
  String cfdi;
  Map<String, String> employees;

  static const _defaultMap = const {"id": "name"};

  Bill(
      {String contableAccount : "",
      num mount : 0.0,
      String rfc : "",
      String desc: "",
      String cfdi: "",
      Map<String, String> employees: const {"id": "name"}}) {
    this.contableAccount = contableAccount;
    this.mount = mount;
    this.rfc = rfc;
    this.desc = desc;
    this.cfdi = cfdi;
    this.employees = {};
    if (!employees.isEmpty &&
        employees[_defaultMap.keys.first] !=
            _defaultMap[_defaultMap.keys.first]) {
      this.employees.addAll(employees);
      /*for(var item in employees.keys){
      this.employees.putIfAbsent(item, ()=>employees[item]);
    }*/
    }
  }

  bool isFilled(){
    return !this.contableAccount.isEmpty && this.mount > 0.0 && !this.rfc.isEmpty;
  }
}

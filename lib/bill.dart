class Bill{
  String contableAccount;
  String rfc;
  String desc;
  String cfdi;
  Map<String, String> employees;
  String empName;

Bill(this.contableAccount, this.rfc, [this.desc = "",
        this.cfdi = "", this.employees=const {'id':'', 'name':''}]);
}
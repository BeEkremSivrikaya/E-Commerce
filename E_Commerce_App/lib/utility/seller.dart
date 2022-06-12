import 'account.dart';

class Seller {
  String? id, name, surname, eMail, password, telNumber;
  Account? account;
  Seller(
      {this.id,
      this.name,
      this.surname,
      this.eMail,
      this.password,
      this.telNumber,
      this.account});
}

import 'account.dart';

class User{
  String? id, name, surname, eMail, password, telNumber,accountId;
  var products;
  Account? account;
  User({this.id, this.name, this.surname, this.eMail, this.password, this.telNumber,this.accountId,this.account,this.products});
}
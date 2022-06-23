import 'account.dart';

class User{
  String? id, name, surname, eMail, password, telNumber;
  Account? account;
  User({this.id, this.name, this.surname, this.eMail, this.password, this.telNumber,this.account});
}
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';

class User extends UserEntity{
  
  User(
      {int id = -1,
    String email = '',
      String password = '',
     String status = ''}) : super(id: id, email: email, password: password);

  factory User.fromJson(dynamic json) {
    return User(id: json['id'], email: json['email'], password: json['password'], status: json['status_delet']);
  
  }

  @override
  String toString() {
    return "User('id': $id, 'email': $email, 'password': $password, 'status': $status)";
  }
}

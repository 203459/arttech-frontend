import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String password;
  final bool isOnline;
  final String status;

  UserEntity({
    required this.id,
    required this.email,
    required this.password,
    this.isOnline = false,
    this.status = "",
  });

  factory UserEntity.fromJson(dynamic json) {
    return UserEntity(id: json['id'], email: json['email'], password: json['password'], status: json['status_delet']);
  
  }

  @override
  String toString() {
    return "User('id': $id, 'email': $email, 'password': $password, 'status': $status, 'isOnline': $isOnline)";
  }

  @override
  List<Object> get props => [
        id,
        email,
        isOnline,
        status,
        password,
      ];
}

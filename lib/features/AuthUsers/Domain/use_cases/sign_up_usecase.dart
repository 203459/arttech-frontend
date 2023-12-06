import 'package:proyecto_c2/features/AuthUsers/Data/models/user.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final AuthFirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<UserEntity> call(UserEntity user) {
    return repository.signUp(user);
  }
}

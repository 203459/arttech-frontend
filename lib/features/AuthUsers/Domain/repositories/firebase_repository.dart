import 'package:proyecto_c2/features/AuthUsers/Data/models/user.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';

abstract class AuthFirebaseRepository {
  //Future<void> getCreateCurrentUser(UserEntity user);
  //Future<void> googleAuth();
  Future<bool> isSignIn();
  Future<int> signIn(UserEntity user);
  Future<UserEntity> signUp(UserEntity user);
  Future<void> signOut();
  //Future<void> getUpdateUser(UserEntity user);
  Future<int> getCurrentUId();
  //Stream<List<UserEntity>> getAllUsers();
}

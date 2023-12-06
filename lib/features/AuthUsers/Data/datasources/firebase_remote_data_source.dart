
import '../../Domain/entities/user_entity.dart';

abstract class AuthFirebaseRemoteDataSource {
  //Future<void> getCreateCurrentUser(UserEntity user);

  Future<int> signIn(UserEntity user);

  Future<UserEntity> signUp(UserEntity user);
  

  Future<void> getUpdateUser(UserEntity user);

  //Future<void> googleAuth();

  Future<bool> isSignIn();

  Future<void> signOut();

  Future<int> getCurrentUId();


  //Stream<List<UserEntity>> getAllUsers();
}

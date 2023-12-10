import 'package:proyecto_c2/features/AuthUsers/Data/datasources/user_remote_data_source.dart';
import 'package:proyecto_c2/features/AuthUsers/Data/models/user.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/repositories/firebase_repository.dart';

class AuthFirebaseRepositoryImpl implements AuthFirebaseRepository {
  final AuthUserRemoteDataSource remoteDataSource;

  AuthFirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> isSignIn() async => await remoteDataSource.isSignIn();

   @override
  Future<int> getCurrentUId() async =>
      await remoteDataSource.getCurrentUId();

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  /*@override
  Stream<List<UserEntity>> getAllUsers() => remoteDataSource.getAllUsers();*/

  @override
  Future<int> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<UserEntity> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  /*@override
  Future<void> getUpdateUser(UserEntity user) async =>
      remoteDataSource.getUpdateUser(user);*/
}

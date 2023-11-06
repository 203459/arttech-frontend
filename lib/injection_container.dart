import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_c2/features/AuthUsers/Data/datasources/firebase_remote_data_source.dart';
import 'package:proyecto_c2/features/AuthUsers/Data/datasources/firebase_remote_data_source_impl.dart';
import 'package:proyecto_c2/features/AuthUsers/Data/repositories/firebase_repository_impl.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/repositories/firebase_repository.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/get_all_users_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/get_create_current_user_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/get_current_uid_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/get_update_user_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/google_sign_in_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/is_sign_in_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/sign_in_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/sign_out_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/sign_up_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/auth/auth_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/credential/credential_cubit.dart';
import 'package:proyecto_c2/features/AuthUsers/Presentation/cubit/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Future bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        isSignInUseCase: sl.call(),
        signOutUseCase: sl.call(),
        getCurrentUIDUseCase: sl.call(),
      ));
  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      getCreateCurrentUserUseCase: sl.call(),
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
      googleSignInUseCase: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getAllUsersUseCase: sl.call(),
        getUpdateUserUseCase: sl.call(),
      ));

  //UseCases
  sl.registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIDUseCase>(
      () => GetCurrentUIDUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: sl.call()));

  //Repository
  sl.registerLazySingleton<AuthFirebaseRepository>(
      () => AuthFirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<AuthFirebaseRemoteDataSource>(
      () => AuthFirebaseRemoteDataSourceImpl(sl.call(), sl.call(), sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => googleSignIn);
}

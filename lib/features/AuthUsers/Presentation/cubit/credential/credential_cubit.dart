import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/sign_up_usecase.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/use_cases/sign_in_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;

  CredentialCubit({
    required this.signUpUseCase,
    required this.signInUseCase,
  }) : super(CredentialInitial());

  Future<void> signInSubmit(
      {int id = -1, required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      final userId = await signInUseCase
          .call(UserEntity(id: id, email: email, password: password));
      emit(CredentialSuccess(id: userId));
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  /*Future<void> googleAuthSubmit() async {
    emit(CredentialLoading());
    try {
      await googleSignInUseCase.call();
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }*/

  Future<void> signUpSubmit({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      final newUser = await signUpUseCase.call(
          UserEntity(id: user.id, email: user.email, password: user.password));
      emit(CredentialSuccess(id: newUser.id));
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}

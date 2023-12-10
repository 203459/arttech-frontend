import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_c2/constants/api_constants.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';
import 'package:proyecto_c2/utils/http_helper.dart';

import '../models/user.dart';
import 'firebase_remote_data_source.dart';

class AuthFirebaseRemoteDataSourceImpl implements AuthFirebaseRemoteDataSource {
  final FirebaseFirestore fireStore;
  final firebase_auth.FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();


  String _verificationId = "";

  AuthFirebaseRemoteDataSourceImpl(
      this.fireStore, this.auth, this.googleSignIn);

  @override
  Future<bool> isSignIn() async =>
      //TODO: Reemplazar por el valor almacenado en el flutter secure storage
      //mandar a llamar a getUserId()
      // localStorage.getUserId() != -1
      //auth.currentUser?.uid != null;
      await secureStorage.read(key: 'token') != null;

  @override
  Future<int> getCurrentUId() async =>
      //TODO: Reemplazar por el valor almacenado en el flutter secure storage
      //1.- crear un metodo getUserId (localStorage.getUserId())
      int.tryParse(await secureStorage.read(key: 'userId') ?? '') ?? -1;

  @override
  Future<int> signIn(UserEntity user) async {
    var headers = HttpHelper.setJsonHeader();
    

    var data = {
      'email': user.email,
      'password': user.password,
    };

    try {
      final response = await HttpHelper.postData(
          baseUrl + ApiConstants.loginUser, data, headers, apiLongTimeOut);

      if (response.containsKey('status') && response['status'] != 'success') {
        print(response);
        throw Exception(response['status']);
      } else {
        //decode jwt
        String? jwt = response['token'];

        Map<String, dynamic> payload = json.decode(
            ascii.decode(base64.decode(base64.normalize(jwt!.split(".")[1]))));

        print(payload);
        await secureStorage.write(key: 'token', value: jwt);
        await secureStorage.write(key: 'userId', value: payload['id'].toString());
        //TODO: Save token
        //1. Crear instancia de flutter secure storage
        //2.- Guardar el token en la instancia de flutter secure storage
        //3.- Guardar el id en la instancia del flutter secure storage

        //localStorage.setToken(jwt);
        //localStorage.setUserId(payload['id']);
        //localStorage.getUser();

        return payload['id'];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    //TODO: Crear metodo en la clase donde se usa flutter secure storage para eliminar las keys guardadas
    //1.- localStorage.delete() => esta funcion deberia eliminar todas las keys
    //flutterSecureStorage = FlutterSecureStorage()
    //flutterSecureStorage.clearAllKeys();
    //await auth.signOut();
    await secureStorage.deleteAll();
    await auth.signOut();
  }

  @override
  Future<UserEntity> signUp(UserEntity user) async {
    var headers = HttpHelper.setJsonHeader();

    var data = {
      'email': user.email,
      'password': user.password,
    };

    try {
      final response = await HttpHelper.postData(
          baseUrl + ApiConstants.postUser, data, headers, apiLongTimeOut);

      if (response.containsKey('status') && response['status'] != 'success') {
        print(response);
        throw Exception(response['status']);
      } else {
        var user = User.fromJson(response['data']['createUser']);
        return user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  @override
  Future<void> getUpdateUser(UserEntity user) {
    // TODO: implement getUpdateUser
    throw UnimplementedError();
  }

}

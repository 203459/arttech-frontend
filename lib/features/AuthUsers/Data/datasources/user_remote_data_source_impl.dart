import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proyecto_c2/constants/api_constants.dart';
import 'package:proyecto_c2/features/AuthUsers/Domain/entities/user_entity.dart';
import 'package:proyecto_c2/utils/http_helper.dart';
import '../models/user.dart';
import 'user_remote_data_source.dart';

class AuthUserRemoteDataSourceImpl implements AuthUserRemoteDataSource {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();


  String _verificationId = "";

  AuthUserRemoteDataSourceImpl(FlutterSecureStorage);

  @override
  Future<bool> isSignIn() async =>
      await secureStorage.read(key: 'token') != null;

  @override
  Future<int> getCurrentUId() async =>
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
    
    await secureStorage.deleteAll();
    //await auth.signOut();
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

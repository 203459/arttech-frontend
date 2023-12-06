import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proyecto_c2/constants/api_constants.dart';

class HttpHelper {
  static postData(endpoint, data, headers, int timeOut) async {
    var fullUrl = Uri.parse(endpoint);
    var body = jsonEncode(data);
    try {
      final response = await http
          .post(
            fullUrl,
            body: body,
            headers: headers,
          )
          .timeout(Duration(seconds: timeOut));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else if (response.statusCode == 401 || response.statusCode == 471) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw HttpException('${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      var msg = "${e.message} (TimeoutException)";
      var errorData = {"code": 1, "status": "Error", "message": msg};
      apiLongTimeOut += 25;
      apiShortTimeout += 12;
      return errorData;
    } on SocketException catch (e) {
      var msg = e.message.contains("host lookup:")
          ? e.message.split(':')[0]
          : e.message;
      var errorData = {"code": 2, "status": "Error", "message": msg};
      return errorData;
    } on HttpException catch (e) {
      var msg = "Error en servidor HTTP (${e.message})";
      var errorData = {"code": 3, "status": "Error", "message": msg};
      return errorData;
    } on FormatException {
      var msg = "Formato de respuesta invalido";
      var errorData = {"code": 4, "status": "Error", "message": msg};
      return errorData;
    } catch (e) {
      var msg = "{$e}";
      var errorData = {"code": 5, "status": "Error", "message": msg};
      return errorData;
    }
  }

  static getData(endpoint, headers, int timeOut) async {
    var fullUrl = Uri.parse(endpoint);
    try {
      final response = await http
          .get(
            fullUrl,
            headers: headers,
          )
          .timeout(Duration(seconds: timeOut));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else if (response.statusCode == 401 || response.statusCode == 471) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw HttpException('${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      apiLongTimeOut += 10;
      apiShortTimeout += 10;
      throw Exception(
          "Excepción de tiempo de espera, verifica la calidad de tu conexión de internet");
    } on SocketException catch (_) {
      throw Exception(
          "Excepción de conexión, no se ha logrado contactar al servidor API");
    } on HttpException catch (e) {
      var msg = "Error en servidor HTTP (${e.message})";
      throw Exception(msg);
    } on FormatException {
      var msg = "Formato de respuesta API invalida";
      throw Exception(msg);
    } on Exception catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      var msg = "{$e}";
      throw Exception(
         msg);
    }
  }

  static setJsonHeader() => {
        'Access-Control-Allow-Origin': '*',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  static setTokenHeaders(String token) {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}

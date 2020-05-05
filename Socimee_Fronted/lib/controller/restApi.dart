import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

class HttpRequest{

  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');

  Future<bool> doPost(String url, Map<String, dynamic> body) async{
    String jsonBody = json.encode(body);
    Response response = await post(url, headers: headers, body: jsonBody, encoding: encoding);

    if(response.statusCode == 404){
      return Future<bool>.value(null);
    }
    return Future<bool>.value(true);
  }

  Future<String> doGet(String url) async{
    var response = await get(url, headers: headers);

    var data = json.decode(response.body);
    
    return Future<String>.value(data);
  }

  Future<String> doCreate(String url, Map<String, dynamic> body) async{
    String jsonBody = json.encode(body);
    Response response = await post(url, headers: headers, body: jsonBody, encoding: encoding);

    return Future<String>.value(response.body);
  }

  Future<String> doPut(String url , Map<String, dynamic> body) async{
    String jsonBody = json.encode(body);
    Response response = await put(url, headers: headers, body: jsonBody, encoding: encoding);
    
    return Future<String>.value(response.body);
  }

  Future<String> doDelete(String url) async{    
    Response response = await delete(url);    
    return Future<String>.value(response.body);
  }

  Future<String> doLogin(String url, Map<String, dynamic> body) async{
    String jsonBody = json.encode(body);
    Response response = await post(url, headers: headers, body: jsonBody, encoding: encoding);

    return Future<String>.value(response.body);
  }

}
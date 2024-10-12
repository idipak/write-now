import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final networkClientProvider = Provider((ref) => NetworkClient());

class NetworkClient{

  final urlScheme = 'http';
  static const baseUrl = 'ec2-35-154-50-148.ap-south-1.compute.amazonaws.com';
  final int portNumber = 8085;

  Future<http.Response> getRequest(String path, {Map<String, dynamic>? queryParameters})async{
    final httpUri = Uri(
      scheme: urlScheme,
      host: baseUrl,
      port: portNumber,
      path: path,
      queryParameters: queryParameters
    );
    try{
      return await http.get(httpUri);
    }catch(_){
      rethrow;
    }
  }

  Future<http.Response> postRequest(String path, {Map<String, dynamic>? body, queryParameters})async{
    final httpUri = Uri(
        scheme: urlScheme,
        host: baseUrl,
        port: portNumber,
        path: path,
      queryParameters: queryParameters
    );
    final header = {"Content-Type": "application/json"};
    try{
      return await http.post(httpUri, body: jsonEncode(body), headers: header);
    }catch(_){
      rethrow;
    }
  }

  Future<http.StreamedResponse> multiPartRequest(String path, List<http.MultipartFile> files, {Map<String, String>? body, queryParameters})async{
    final httpUri = Uri(
        scheme: urlScheme,
        host: baseUrl,
        port: portNumber,
        path: path,
        queryParameters: queryParameters
    );
    var request = http.MultipartRequest('POST', httpUri);
    request.headers['Content-Type'] = 'multipart/form-data';

    request.files.addAll(files);

    if(body != null){
      request.fields.addAll(body);
    }
    print("MULTIPART FIELDS: ${request.fields}");
    return await request.send();
  }

  // Future<http.StreamedResponse> multiPartRequestTest(String filePath)async{
  //   final httpUri = Uri(
  //       scheme: urlScheme,
  //       host: baseUrl,
  //       port: portNumber,
  //       path: '/bhealth/post',
  //   );
  //   var request = http.MultipartRequest('POST', httpUri);
  //   request.headers['Content-Type'] = 'multipart/form-data';
  //   http.MultipartFile file = await http.MultipartFile.fromPath('postPicture', filePath);
  //   request.files.add(file);
  //   request.fields['postInfo'] = jsonEncode({"postId":"1","title":"Hair Fall","content":"Hair Loss Has Multiple Root Causes","authorId":"1","forumId":"1","likes":1,"shares":1,"saves":1,"comments":2});
  //
  //   print("MULTIPART FIELDS: ${request.fields}");
  //   return await request.send();
  // }


}
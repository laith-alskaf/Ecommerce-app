import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class NetworkUtil {
  static String baseUrl = 'ecommerce-backend-clean-architecture.vercel.app';
  static var client = http.Client();

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    try {
      Map<String, String> stringParams = {};
      if (params != null) {
        params.forEach((key, value) {
          stringParams[key] = value.toString();
        });
      }

      //!--- Required for request ----
      //*--- Make full api url ------
      var uri = Uri.https(baseUrl, url, stringParams);
      log('==========> $uri');
      //?--- To Save api response ----
      late http.Response
      response;
      //?--- To Save api status code ----

      //!--- Required convert ap i response to Map ----
      Map<String, dynamic> jsonResponse = {};

      //*--- Make call correct request type ------
      switch (type) {
        case RequestType.GET:
          response = await client
              .get(uri, headers: headers)
              .timeout(
                const Duration(seconds: 10),
                onTimeout: () {
                  return response;
                },
              );
          break;
        case RequestType.POST:
          response = await client
              .post(uri, body: jsonEncode(body), headers: headers)
              .timeout(
                const Duration(seconds: 10),
                onTimeout: () {
                  return response;
                },
              );
          break;
        case RequestType.PUT:
          response = await client
              .put(uri, body: jsonEncode(body), headers: headers)
              .timeout(
                const Duration(seconds: 10),
                onTimeout: () {
                  return response;
                },
              );

          break;
        case RequestType.DELETE:
          response = await client.delete(
            uri,
            body: jsonEncode(body),
            headers: headers,
          );
          break;
        case RequestType.MULTIPART:
          // TODO: Handle this case.
          break;
      }

      dynamic result;

      try {
        result = jsonDecode(const Utf8Codec().decode(response.bodyBytes));
      } catch (e) {
        e;
      }

      jsonResponse.putIfAbsent(
        'response',
        () =>
            result == null
                ? jsonDecode(
                  jsonEncode({
                    'title': const Utf8Codec().decode(response.bodyBytes),
                  }),
                )
                : jsonDecode(const Utf8Codec().decode(response.bodyBytes)),
      );
      jsonResponse.putIfAbsent('statusCode', () => response.statusCode);

      log(jsonResponse.toString());

      return jsonResponse;
    } catch (e) {
      (e);
    }
  }

  static Future<dynamic> sendMultipartRequest({
    required String url,
    required RequestType type,
    Map<String, String>? headers = const {},
    Map<String, String>? fields = const {},
    Map<String, List<String>>? files = const {},
    Map<String, dynamic>? params,
  }) async {
    try {
      var uri = Uri.https(baseUrl, url, params);
      var request = http.MultipartRequest('POST', uri);
      log(uri.toString());
      var futures = <Future>[];

      files!.forEach((key, value) {
        if (value.isNotEmpty) {
          for (var element in value) {
            var multipartFile = http.MultipartFile.fromPath(
              key,
              element,
              filename: path.basename(element),
              contentType: MediaType.parse(lookupMimeType(element) ?? ''),
            );
            futures.add(multipartFile);
          }
        }
      });
      var multipartFiles = await Future.wait(futures);
      for (var file in multipartFiles) {
        request.files.add(file);
      }

      request.headers.addAll(headers!);
      request.fields.addAll(fields!);

      var response = await request.send().timeout(Duration(minutes: 1));

      Map<String, dynamic> responseJson = {};
      var value;
      try {
        value = await response.stream.bytesToString();
      } catch (e) {
        print(e);
      }
      responseJson.putIfAbsent('statusCode', () => response.statusCode);
      responseJson.putIfAbsent('response', () => jsonDecode(value));
      log(responseJson.toString());
      return responseJson;
    } catch (error) {
      error.toString();
    }
  }

  static MediaType getContentType(String name) {
    var ext = name.split('.').last.toLowerCase();
    MediaType mediaType;
    if (ext == ("png")) {
      mediaType = MediaType.parse("image/png");
    } else if (ext == "jpeg" || ext == "jpg") {
      mediaType = MediaType.parse("image/jpeg");
    } else if (ext == "gif") {
      mediaType = MediaType.parse("image/gif");
    } else if (ext == "bmp") {
      mediaType = MediaType.parse("image/bmp");
    } else if (ext == "webp") {
      mediaType = MediaType.parse("image/webp");
    } else if (ext == "pdf") {
      mediaType = MediaType.parse("application/pdf");
    } else if (ext == "doc" || ext == "docx") {
      mediaType = MediaType.parse("application/vnd.ms-word");
    } else if (ext == "xls" || ext == "xlsx") {
      mediaType = MediaType.parse("application/vnd.ms-excel");
    } else if (ext == "ppt" || ext == "pptx") {
      mediaType = MediaType.parse("application/vnd.ms-powerpoint");
    } else {
      mediaType = MediaType.parse("application/octet-stream");
    }
    return mediaType;
  }
}

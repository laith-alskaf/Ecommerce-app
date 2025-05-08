import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:simple_e_commerce/core/enums/request_type.dart';

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
      response; // حتى يتم استقبال البيانات من http ويتم تاخير تعريفه حتى يتم طلبه
      //?--- To Save api status code ----

      //!--- Required convert ap i response to Map ----
      Map<String, dynamic> jsonResponse = {};

      //*--- Make call correct request type ------
      switch (type) {
        case RequestType.GET:
          response = await client
              .get(uri, headers: headers)
              .timeout(
                const Duration(seconds: 15),
                onTimeout: () {
                  return response;
                },
              );
          break;
        case RequestType.POST:
          response = await client
              .post(uri, body: jsonEncode(body), headers: headers)
              .timeout(
                const Duration(seconds: 15),
                onTimeout: () {
                  return response;
                },
              );
          break;
        case RequestType.PUT:
          response = await client
              .put(uri, body: jsonEncode(body), headers: headers)
              .timeout(
                const Duration(seconds: 15),
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
}

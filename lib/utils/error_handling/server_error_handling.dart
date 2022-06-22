import 'package:http/http.dart' as http;

class ServerErrorHandler {
  ServerErrorHandler();

  static String getErrorMessage(http.Response response) {
    final statusCode = response.statusCode;

    final now = DateTime.now();
    if (statusCode >= 500) {
      return '${response.reasonPhrase}. Please report an error at ${now.toUtc().toString()}';
    } else if (statusCode >= 400) {
      try {
        final responseBody = response.body as Map<String, dynamic>;
        if (responseBody.containsKey('detail')) {
          return responseBody['detail'];
        } else {
          final hold = <String>[];
          for (final key in responseBody.keys) {
            hold.add('$key: ${responseBody[key]}');
          }
          return '${response.reasonPhrase}. Details:\n${hold.join('\n')}';
        }
        // } on FormatException {
        //   return '${response.reasonPhrase}. Please report an error at ${now.toUtc().toString()}';
      } catch (e) {
        return '${response.reasonPhrase}. Please report an error at ${now.toUtc().toString()}\n\nDetails:${response.body}';
      }
    } else if (statusCode >= 300) {
      return 'Redirection';
    } else if (statusCode >= 200) {
      return 'Success';
    } else if (statusCode >= 100) {
      return 'Informational';
    } else {
      return 'Unknown status code $statusCode.';
    }
  }
}

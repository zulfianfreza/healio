import 'dart:convert';
import 'package:http/http.dart' as http;

class PushNotificationService {
  String baseUrl = "https://fcm.googleapis.com/fcm/send";

  Future<bool> pushNotification(
    String title,
    String desc,
  ) async {
    var url = Uri.parse(baseUrl);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAstAiflM:APA91bHcn_64JkornQ-u6KRSZtE-C_n2-dHgV7PzqQj7kj83AVAK43AfXGM659FxEjqxH2bQXwE6MbNhzOatFTOAq9kLGjwhMbDtgy5AA2RapIdNhRiMMJHNBr9vTM-6NHSS-c6Vc23x',
    };
    var body = jsonEncode({
      "to": "/topics/health",
      "collapse_key": "type_a",
      "notification": {
        "title": title,
        "body": desc,
      }
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

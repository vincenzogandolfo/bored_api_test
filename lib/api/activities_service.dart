import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/activity_model.dart';

class ActivitiesServices {
  Future<Activity> getActivity() async {
    final response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Activity.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}

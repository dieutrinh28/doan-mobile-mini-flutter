

import 'dart:convert';
import 'package:doan_mini_flutter/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class NetworkRequest {
  static const String url = 'https://api.npoint.io/2d8611e51e69002103b2';

  static List<User> parseUser(String responseBody) {
    var list = json.decode(responseBody) as  List<dynamic>;
    List<User> users = list.map((model) => User.fromJson(model)).toList();
    return users;
  }

  static Future<List<User>> fetchUser ({int id = 1}) async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      return compute(parseUser,response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Cant get user');
    }
  }
}
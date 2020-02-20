import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/http.dart';
import 'package:testing/router/navigation.dart';
import 'package:testing/router/router.dart';
import 'package:testing/services/local_storage.dart';
import 'package:testing/services/user_api_client.dart';
import 'package:testing/widgets/home_page.dart';

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
  dio.interceptors
    ..add(LogInterceptor(
        responseBody: true, requestBody: false, responseHeader: false));
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: UserApiClient()),
        Provider.value(value: LocalStorage())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: Navigation().navigatorKey,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Home page'),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_state_management/api/dio.dart';

final postProvider = FutureProvider<List>((ref) async {
  final content = await DioApi().request();

  return content;
});

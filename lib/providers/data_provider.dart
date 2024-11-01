import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/services/local_storage_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());
final localStorageProvider = Provider((ref) => LocalStorageService());

final dataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final localStorage = ref.read(localStorageProvider);

  final cachedData = await localStorage.getData('pokemon_data');
  if (cachedData != null) {
    return jsonDecode(cachedData);
  }

  final data = await apiService.fetchData();
  await localStorage.saveData('pokemon_data', jsonEncode(data));
  return data;
});

import 'dart:convert';
import 'package:http/http.dart' as http;
// import '../models/item.dart';
import '../models/todo.dart';

class ApiService {
  final String baseUrl = 'https://crudcrud.com/api/1bf8db313ba543c9b225c2013dee2b5a/items';

  Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
  Future<void> addItem(String name) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
  }

  Future<void> deleteItem(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}

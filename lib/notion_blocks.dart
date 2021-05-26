library notion_api;

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/children.dart';
import 'statics.dart';

/// A client for Notion API block children requests.
class NotionBlockClient {
  // The API integration secret token
  String _token;

  // The path of the requests group
  String _path = 'blocks';

  NotionBlockClient({required token}) : this._token = token;

  /// Retrieve the block children from block with [id]
  Future<http.Response> fetch(
    String id, {
    String? startCursor,
    int? pageSize,
  }) async {
    Map<String, dynamic> query = {};
    if (startCursor != null) {
      query['start_cursos'] = startCursor;
    }
    if (pageSize != null && pageSize >= 0 && pageSize <= 100) {
      query['page_size'] = pageSize;
    }

    return await http.get(Uri.https(host, '$v/$_path/$id/children'), headers: {
      'Authorization': 'Bearer $_token',
    });
  }

  /// Append a block child to the block with [id]
  Future<http.Response> append(
      {required String to, required Children children}) async {
    return await http.patch(Uri.https(host, '$v/$_path/$to/children'),
        body: jsonEncode(children.toJson()),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }
}

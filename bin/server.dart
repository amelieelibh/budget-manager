import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';

void main() {
  runAppEngine(requestHandler);
}

Future requestHandler(HttpRequest request) async {
  if (request.uri.path == '/budget') {
    //handleItems(request);
  } else if (request.uri.path == '/') {
    await request.response.redirect(Uri.parse('/index.html'));
  } else {
    await context.assets.serve();
  }
}
/*
Future handleItems(HttpRequest request) async {
  if (request.method == 'GET') {
    final List<Item> items = await queryItems();
    final result = items.map((item) => item.serialize()).toList();
    final json = {'success': true, 'result': result};
    await sendJSONResponse(request, json);
  } else if (request.method == 'POST') {
    final json = await readJSONRequest(request);
    final item = Item.deserialize(json)..parentKey = itemsRoot;
    final error = item.validate();
    if (error != null) {
      await sendJSONResponse(request, {'success': false, 'error': error});
    } else {
      await dbService.commit(inserts: [item]);
      await sendJSONResponse(request, {'success': true});
    }
  }
}*/

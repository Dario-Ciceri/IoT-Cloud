import 'dart:io';

import 'package:serverpod/serverpod.dart';

class NotFoundRoute extends WidgetRoute {
  @override
  Future<Widget> build(Session session, HttpRequest request) async {
    return NotFoundWidget();
  }
}

class NotFoundWidget extends Widget {
  NotFoundWidget() : super(name: 'not_found') {
    values = {
      'title': 'URL non trovato',
      'message': 'Il link richiesto non esiste o è stato rimosso.',
      'statusCode': 404,
    };
  }
}

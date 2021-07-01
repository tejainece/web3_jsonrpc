import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/models.dart';

abstract class JRPC {
  Future<JRPCResponse> callRPC(JRPCRequest req);
}

class JRPCHttp implements JRPC {
  final Uri uri;

  late Client client;

  JRPCHttp(this.uri, {Client? client}) {
    this.client = client ?? Client();
  }

  @override
  Future<JRPCResponse> callRPC(JRPCRequest req) async {
    final resp = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json-rpc',
        HttpHeaders.acceptHeader: 'application/json-rpc'
      },
      body: json.encode(req.toJson()),
    );
    return JRPCResponse.fromMap(json.decode(resp.body));
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:web3_jsonrpc/src/jsonrpc/models.dart';

abstract class JRPCClient {
  String get nextId;
  Future<JRPCResponse> callRPC(JRPCRequest req);
}

class JRPCHttpClient implements JRPCClient {
  final Uri uri;

  late Client client;

  BigInt _id = BigInt.from(0);

  JRPCHttpClient(this.uri, {Client? client}) {
    this.client = client ?? Client();
  }

  @override
  String get nextId {
    _id = _id + BigInt.one;
    return _id.toString();
  }

  @override
  Future<JRPCResponse> callRPC(JRPCRequest req) async {
    final body = json.encode(req.toJson());
    print(body);
    final resp = await client.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json-rpc',
          HttpHeaders.acceptHeader: 'application/json-rpc'
        },
        body: body);
    return JRPCResponse.fromMap(json.decode(resp.body));
  }
}

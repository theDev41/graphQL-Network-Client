import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientConfig {
  static final HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql');

  static ValueNotifier<GraphQLClient> initializeClient() {
    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
    return ValueNotifier(client);
  }
}
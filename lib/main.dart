import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_networkclient/queries.dart';

import 'graphql_client.dart';

void main() {
  runApp(Graphql_client_main());
}
class Graphql_client_main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLClientConfig.initializeClient(),
      child: MaterialApp(
        title: 'GraphQL Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CharacterListScreen(),
      ),
    );
  }
}

class CharacterListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rick and Morty Characters')),
      body: Query(
        options: QueryOptions(document: gql(fetchCharactersQuery)),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text('Error: ${result.exception.toString()}'));
          }

          final List characters = result.data?['characters']['results'] ?? [];

          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character['image']),
                  ),
                  title: Text(character['name']),
                  subtitle: Text('${character['species']} - ${character['status']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

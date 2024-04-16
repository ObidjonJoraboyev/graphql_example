import 'package:graphql/client.dart';
import 'package:graphql_example/data/models/country.dart';
import 'package:graphql_example/data/queries/country.dart';

import '../models/network_response.dart';

class ApiProvider {
  ApiProvider({required this.graphQLClient});

  final GraphQLClient graphQLClient;

  factory ApiProvider.create() {
    final link = Link.from([HttpLink("https://countries.trevorblades.com")]);

    return ApiProvider(
      graphQLClient: GraphQLClient(link: link, cache: GraphQLCache()),
    );
  }

  Future<NetworkResponse> getAllCountries() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result =
          await graphQLClient.query(QueryOptions(document: gql(allCountries)));

      if (result.hasException) {
        networkResponse = networkResponse
          ..errorText = result.exception.toString();
        return networkResponse;
      } else {
        List<AllCountryModel> list = (result.data?["countries"] as List?)
                ?.map((e) => AllCountryModel.fromJson(e))
                .toList() ??
            [];
        networkResponse = networkResponse..data = list;
        return networkResponse;
      }
    } catch (e) {
      networkResponse = networkResponse..errorText = e.toString();
    }
    return networkResponse;
  }

  Future<NetworkResponse> getCountriesByContinents(
      {required String query}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = await graphQLClient.query(
          QueryOptions(document: gql(getCountriesByContinent(query: query))));

      if (result.hasException) {
        networkResponse = networkResponse
          ..errorText = result.exception.toString();
        return networkResponse;
      } else {
        List<CountryModel> list = (result.data?["countries"] as List?)
                ?.map((e) => CountryModel.fromJson(e))
                .toList() ??
            [];
        networkResponse = networkResponse..data = list;
        return networkResponse;
      }
    } catch (e) {
      networkResponse = networkResponse..errorText = e.toString();
    }
    return networkResponse;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_example/blocs/country_event.dart';
import 'package:graphql_example/data/api/api_client.dart';
import 'app/app.dart';
import 'blocs/country_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ApiProvider apiClient =
      ApiProvider(graphQLClient: ApiProvider.create().graphQLClient);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CountriesBloc(apiProvider: apiClient)
            ..add(FetchAllCountriesEvent()),
        )
      ],
      child: const App(),
    ),
  );
}

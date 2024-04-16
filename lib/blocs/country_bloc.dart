import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_example/blocs/country_event.dart';
import 'package:graphql_example/data/api/api_client.dart';

import '../data/models/country.dart';
import '../data/models/network_response.dart';
import 'country_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc({required this.apiProvider}) : super(CountriesInitial()) {
    on<FetchByContCountriesEvent>(
        (FetchByContCountriesEvent event, emit) async {
      emit(CountriesLoading());

      NetworkResponse networkResponse =
          await apiProvider.getCountriesByContinents(query: event.continent);

      if (networkResponse.errorText.isEmpty) {
        emit(CountriesSuccess(networkResponse.data as List<CountryModel>));
      } else {
        emit(CountriesError(networkResponse.errorText));
      }
    });

    on<FetchAllCountriesEvent>((event, emit) async {
      emit(CountriesLoading());

      NetworkResponse networkResponse = await apiProvider.getAllCountries();

      if (networkResponse.errorText.isEmpty) {
        emit(
            AllCountriesSuccess(networkResponse.data as List<AllCountryModel>));
      } else {
        emit(CountriesError(networkResponse.errorText));
      }
    });
  }

  final ApiProvider apiProvider;
}

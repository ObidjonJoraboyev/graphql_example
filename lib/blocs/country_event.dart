abstract class CountriesEvent {}

class FetchByContCountriesEvent extends CountriesEvent {
  final String continent;

  FetchByContCountriesEvent({required this.continent});
}

class FetchAllCountriesEvent extends CountriesEvent {}

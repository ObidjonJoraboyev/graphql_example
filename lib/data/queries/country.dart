const String allCountries = '''
query {
  countries {
    code
    name
    emoji
    capital
  }
}
''';

String getCountriesByContinent({required String query}) {
  return '''query CountriesByContinent {
  countries(filter: { continent: { in: ["$query"] } }) {
    code
    name
    capital
    emoji
    phone
    continent{
      name
    }
  }
}''';
}

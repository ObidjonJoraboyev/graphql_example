import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_example/blocs/country_bloc.dart';
import 'package:graphql_example/blocs/country_event.dart';
import 'package:graphql_example/blocs/country_state.dart';
import 'package:graphql_example/data/models/country.dart';
import 'package:graphql_example/screens/widgets/all_countries_list.dart';
import 'package:graphql_example/screens/widgets/by_continent_list.dart';
import 'package:graphql_example/screens/widgets/error_search.dart';
import 'package:graphql_example/screens/widgets/universal_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  String text = "";

  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text("Countries"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 14,
                        left: 12,
                        bottom: 8,
                        right: focus.hasFocus ? 0 : 12),
                    child: CupertinoTextField(
                      controller: controller,
                      onChanged: (v) {
                        text = v;
                        setState(() {});
                      },
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(.4),
                        ),
                      ),
                      onTap: () {
                        focus.requestFocus();
                        setState(() {});
                      },
                      cursorColor: Colors.blue,
                      focusNode: focus,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      placeholder: " Search",
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(.35)),
                    ),
                  ),
                ),
                focus.hasFocus
                    ? TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.white),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          text = "";
                          controller.text = "";
                          setState(() {});
                          focus.unfocus();
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                    7,
                    (index) => Row(
                          children: [
                            const SizedBox(
                              width: 7,
                            ),
                            UniversalButton(
                                child: names[index],
                                isSelect: activeIndex == index,
                                onTap: () {
                                  activeIndex = index;
                                  setState(() {});

                                  if (activeIndex == 0) {
                                    context
                                        .read<CountriesBloc>()
                                        .add(FetchAllCountriesEvent());
                                  } else {
                                    context.read<CountriesBloc>().add(
                                        FetchByContCountriesEvent(
                                            continent: namesShort[index]));
                                  }
                                }),
                          ],
                        )),
              ],
            ),
          ),
          Expanded(
            flex: 13,
            child: BlocConsumer<CountriesBloc, CountriesState>(
                builder: (context, state) {
                  if (state is CountriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is CountriesInitial) {
                    return const Center(
                      child: Text("Initial"),
                    );
                  }
                  if (state is CountriesError) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  if (state is AllCountriesSuccess) {
                    List<AllCountryModel> countries = state.countries
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();

                    if (countries.isNotEmpty) {
                      return ALlCountriesList(countries: countries);
                    } else {
                      return ErrorSearch(text: text);
                    }
                  }
                  if (state is CountriesSuccess) {
                    List<CountryModel> countries = state.countries
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                    if (countries.isNotEmpty) {
                      return ByContinentList(countries: countries);
                    } else {
                      return ErrorSearch(text: text);
                    }
                  }
                  return Container();
                },
                listener: (e, s) {}),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: activeIndex != 0,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.grey,
          onPressed: () {
            setState(() {
              activeIndex = 0;
            });
            context.read<CountriesBloc>().add(FetchAllCountriesEvent());
          },
          child: const Text(
            "All",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 20)],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> names = [
  "All",
  "Europe",
  "Africa",
  "Asia",
  "Antarctica",
  "North America",
  "South America"
];
List<String> namesShort = ["All", "EU", "AF", "AS", "AN", "NA", "SA"];

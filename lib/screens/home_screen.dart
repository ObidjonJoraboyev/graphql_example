import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_example/blocs/country_bloc.dart';
import 'package:graphql_example/blocs/country_event.dart';
import 'package:graphql_example/blocs/country_state.dart';
import 'package:graphql_example/data/models/country.dart';
import 'package:graphql_example/screens/widgets/universal_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    ? CupertinoTextSelectionToolbarButton(
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.blue),
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
                const SizedBox(
                  width: 7,
                ),
                UniversalButton(
                    child: "All",
                    isSelect: activeIndex == 0,
                    onTap: () {
                      activeIndex = 0;
                      setState(() {});
                      context
                          .read<CountriesBloc>()
                          .add(FetchAllCountriesEvent());
                    }),
                const SizedBox(
                  width: 7,
                ),
                UniversalButton(
                    child: "Europe",
                    isSelect: activeIndex == 1,
                    onTap: () {
                      activeIndex = 1;
                      setState(() {});

                      context
                          .read<CountriesBloc>()
                          .add(FetchByContCountriesEvent(continent: "EU"));
                    }),
                const SizedBox(
                  width: 7,
                ),
                UniversalButton(
                    child: "Africa",
                    isSelect: activeIndex == 2,
                    onTap: () {
                      activeIndex = 2;
                      setState(() {});

                      context
                          .read<CountriesBloc>()
                          .add(FetchByContCountriesEvent(continent: "AF"));
                    }),
                const SizedBox(
                  width: 7,
                ),
                UniversalButton(
                    child: "Asia",
                    isSelect: activeIndex == 3,
                    onTap: () {
                      activeIndex = 3;
                      setState(() {});

                      context
                          .read<CountriesBloc>()
                          .add(FetchByContCountriesEvent(continent: "AS"));
                    }),
                const SizedBox(
                  width: 7,
                ),
                UniversalButton(
                    child: "Antarctica",
                    isSelect: activeIndex == 4,
                    onTap: () {
                      activeIndex = 4;
                      setState(() {});

                      context
                          .read<CountriesBloc>()
                          .add(FetchByContCountriesEvent(continent: "AN"));
                    }),
                const SizedBox(
                  width: 7,
                ),
                UniversalButton(
                    child: "North America",
                    isSelect: activeIndex == 5,
                    onTap: () {
                      activeIndex = 5;
                      setState(() {});

                      context
                          .read<CountriesBloc>()
                          .add(FetchByContCountriesEvent(continent: "NA"));
                    }),
                const SizedBox(
                  width: 7,
                ),
                UniversalButton(
                    child: "South America",
                    isSelect: activeIndex == 6,
                    onTap: () {
                      activeIndex = 6;
                      setState(() {});

                      context
                          .read<CountriesBloc>()
                          .add(FetchByContCountriesEvent(continent: "SA"));
                    }),
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
                      return Scrollbar(
                        thickness: 5,
                        trackVisibility: false,
                        radius: const Radius.circular(10),
                        child: ListView(
                          children: List.generate(
                            countries.length,
                            (index) => Column(
                              children: [
                                ListTile(
                                  onTap: () {},
                                  subtitle:
                                      Text(state.countries[index].capital),
                                  trailing: Text(
                                    countries[index].emoji,
                                    style: const TextStyle(fontSize: 23),
                                  ),
                                  title: Text(
                                    countries[index].name,
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  color: Colors.black.withOpacity(.3),
                                  width: double.infinity,
                                  height: 0.3,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 62,
                              color: Colors.black.withOpacity(.6),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 44),
                              child: Text(
                                "No result for \"$text\"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              "Check the spelling on try a new speech.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(.35)),
                            ),
                            const SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      );
                    }
                  }
                  if (state is CountriesSuccess) {
                    List<CountryModel> countries = state.countries
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                    if (countries.isNotEmpty) {
                      return Scrollbar(
                        thickness: 5,
                        trackVisibility: false,
                        radius: const Radius.circular(10),
                        child: ListView(
                          children: List.generate(
                            countries.length,
                            (index) => Column(
                              children: [
                                ListTile(
                                  onTap: () {},
                                  subtitle:
                                      Text(countries[index].continentName),
                                  trailing: Text(
                                    countries[index].emoji,
                                    style: const TextStyle(fontSize: 23),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  title: Text(countries[index].name),
                                ),
                                Container(
                                  color: Colors.black.withOpacity(.3),
                                  width: double.infinity,
                                  height: 0.3,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 62,
                              color: Colors.black.withOpacity(.6),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 44),
                              child: Text(
                                "No result for \"$text\"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              "Check the spelling on try a new speech.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(.35)),
                            ),
                            const SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      );
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

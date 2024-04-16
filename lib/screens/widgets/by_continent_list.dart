import 'package:flutter/material.dart';

import '../../data/models/country.dart';

class ByContinentList extends StatelessWidget {
  const ByContinentList({super.key, required this.countries});

  final List<CountryModel> countries;
  @override
  Widget build(BuildContext context) {
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
                subtitle: Text(countries[index].continentName),
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
  }
}

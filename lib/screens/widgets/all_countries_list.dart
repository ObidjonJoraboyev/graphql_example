import 'package:flutter/material.dart';

import '../../data/models/country.dart';

class ALlCountriesList extends StatelessWidget {
  const ALlCountriesList({super.key, required this.countries});

  final List<AllCountryModel> countries;
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
                subtitle: Text(countries[index].capital),
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
  }
}

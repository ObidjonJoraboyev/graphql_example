import 'package:flutter/material.dart';

class ErrorSearch extends StatelessWidget {
  const ErrorSearch({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 44),
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

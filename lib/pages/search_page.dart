import 'package:bus_reservation_flutter_starter/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: [
              DropdownButtonFormField(
                value: fromCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                hint: const Text('Form'),
                isExpanded: true,
                items: cities
                    .map(
                      (city) => DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  fromCity = value;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: toCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                hint: const Text('To'),
                isExpanded: true,
                items: cities
                    .map(
                      (city) => DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  toCity = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

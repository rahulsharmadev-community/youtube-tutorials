import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            inputDecorationTheme:
                const InputDecorationTheme(border: OutlineInputBorder())),
        // ignore: prefer_const_constructors
        home: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const AutocompleteBasicExample(),
        ),
      ),
    );

const countries = ["United States", "Brazil", "Australia", "India"];

class AutocompleteBasicExample extends StatefulWidget {
  const AutocompleteBasicExample({super.key});

  @override
  State<AutocompleteBasicExample> createState() =>
      _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  var selectedCountries = <String>[];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          itemCount: selectedCountries.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(selectedCountries[index]),
            onTap: () {
              setState(() => selectedCountries.removeAt(index));
            },
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Autocomplete<String>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return [];
              }
              return countries.where((e) {
                return e.toLowerCase().contains(textEditingValue.text);
              });
            },
            onSelected: (selected) => setState(() {
              selectedCountries.add(selected);
            }),
          ),
        ),
      );
}

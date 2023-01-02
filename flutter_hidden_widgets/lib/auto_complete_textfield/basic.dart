import 'package:flutter/material.dart';
import 'package:flutter_hidden_widgets/raw_data/countries_and_cities.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AutocompleteBasicExample(),
      ),
    );

class AutocompleteBasicExample extends StatefulWidget {
  const AutocompleteBasicExample({super.key});

  @override
  State<AutocompleteBasicExample> createState() =>
      _AutocompleteBasicExampleState();
}
// Center(
//         child: Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return [];
//         }
//         return countries.where((String option) {
//           return option
//               .toLowerCase()
//               .contains(textEditingValue.text.toLowerCase());
//         });
//       },
//       onSelected: (String selected) {
//         debugPrint('You just selected $selected');
//       },
//     ));
class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  var selectedCountries = <String>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: autoCompleteTextField(),
        ),
        Expanded(
          child: Wrap(
            children: selectedCountries
                .map(
                  (e) => Chip(
                    label: Text(e),
                    onDeleted: () => selectedCountries.remove(e),
                  ),
                )
                .toList(),
          ),
        )
      ],
    ));
  }

  TextEditingController controller = TextEditingController();

  Widget autoCompleteTextField() => RawAutocomplete<String>(
        textEditingController: controller,
        focusNode: FocusNode(),
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) =>
                TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        ),
        optionsViewBuilder: (context, onSelected, options) =>
            _AutoOptionsViewBuilder(
          context: context,
          onSelected: (s) {
            onSelected(s);
            controller.clear();
          },
          options: options,
        ),
        optionsBuilder: (TextEditingValue value) {
          if (value.text.isEmpty) {
            return [];
          }
          return countries_and_cities.keys.where((String country) {
            return country.toLowerCase().contains(value.text.toLowerCase());
          });
        },
        // fieldViewBuilder:
        //     (context, textEditingController, focusNode, onFieldSubmitted) =>
        //         _AutocompleteField(
        //             focusNode: focusNode,
        //             onFieldSubmitted: onFieldSubmitted,
        //             textEditingController: textEditingController),
        onSelected: (String text) {
          setState(() => selectedCountries.add(text));
          debugPrint('You just selected $text');
        },
      );
}

class _AutoOptionsViewBuilder extends StatelessWidget {
  final BuildContext context;
  final Function(String) onSelected;
  final Iterable<String> options;
  const _AutoOptionsViewBuilder({
    Key? key,
    required this.context,
    required this.onSelected,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, i) {
            var item = options.elementAt(i);
            return ListTile(
              title: Text(item),
              onTap: () {
                onSelected(item);
              },
            );
          }),
    );
  }
}

// The default Material-style Autocomplete text field.
class _AutocompleteField extends StatelessWidget {
  const _AutocompleteField({
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  });

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
          suffix: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: textEditingController.clear,
      )),
      onFieldSubmitted: (String value) => onFieldSubmitted(),
    );
  }
}

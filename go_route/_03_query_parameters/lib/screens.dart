part of 'main.dart';

/// The home screen that shows a list of families.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(App.title),
      ),
      body: ListView(
        children: <Widget>[
          for (final String fid in families.keys)
            ListTile(
              title: Text(families[fid]['name']),
              onTap: () {
                context.goNamed('family', params: {
                  'fid': fid
                }, queryParams: {
                  'sort': 'asc'
                } //<- Query Parameters As Map<String, dynamic>,
                    );
              },
            )
        ],
      ),
    );
  }
}

/// The screen that shows a list of persons in a family.
class FamilyScreen extends StatelessWidget {
  /// Creates a [FamilyScreen].
  const FamilyScreen({required this.fid, required this.asc, Key? key})
      : super(key: key);

  /// The family to display.
  final String fid;

  /// Whether to sort the name in ascending order.
  final bool asc;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> newQueries;
    final List<String> names = families[fid]['people']
        .values
        .map<String>((dynamic p) => p['name'] as String)
        .toList();

    names.sort(); // ascending

    newQueries = asc ? {'sort': 'desc'} : {'sort': 'asc'};

    return Scaffold(
      appBar: AppBar(title: Text(families[fid]['name'])),

      // action button for sorting
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('family',
            params: <String, String>{'fid': fid},
            queryParams: newQueries // nothing but the Map<String, dynaic>,
            ),
        child: const Icon(Icons.sort),
      ),

      body: ListView(
        children: <Widget>[
          for (final String name in asc
              ? names
              : names
                  .reversed) // names: - ascending | name.reversed :- descending
            ListTile(
              title: Text(name),
            ),
        ],
      ),
    );
  }
}

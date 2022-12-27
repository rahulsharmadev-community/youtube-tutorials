part of 'main.dart';

/// The home screen that shows a list of families.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(App.title)),
      body: ListView(
        children: [
          for (final family in families.entries)
            ListTile(
              title: Text(family.value['name']),
              onTap: () => context.push(
                  context.namedLocation('family', params: {'fid': family.key})),
            )
        ],
      ),
    );
  }
}

/// The screen that shows a list of persons in a family.
/// fid* = Family id (required)
class FamilyScreen extends StatelessWidget {
  const FamilyScreen({required this.fid, Key? key}) : super(key: key);
  final String fid;

  @override
  Widget build(BuildContext context) {
    final people = families[fid]['people'] as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(title: Text(families[fid]['name'])),
      body: ListView(
        children: <Widget>[
          for (final String pid in people.keys)
            ListTile(
                title: Text(people[pid]['name']),
                onTap: () {
                  context.push(context.namedLocation('person',
                      params: {'fid': fid, 'pid': pid}));
                }),
        ],
      ),
    );
  }
}

/// The person screen.
/// fid* = family id (required)
/// pid* = person id (required)
class PersonScreen extends StatelessWidget {
  const PersonScreen({required this.fid, required this.pid, Key? key})
      : super(key: key);

  // family id
  final String fid;

  // person id
  final String pid;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> family = families[fid];
    final Map<String, dynamic> person = family['people'][pid];
    return Scaffold(
      appBar: AppBar(title: Text(person['name'])),
      body: Center(
        child: Text(
          '''
          Person name: ${person['name']}
          Person age: ${person['age']}
          Family name: ${family['name']}
          ''',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

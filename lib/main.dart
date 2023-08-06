import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// --------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Test App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// --------------------------

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  // Change word function, next button
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
  var favorites = <WordPair>[];

  // Add Favorite button function
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

} // end myappstate

// --------------------------

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          // center texts/cards
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            //Text('A random idea:'),
            //Text(appState.current.asLowerCase),

            // Text inside card
            BigCard(pair: pair),
            SizedBox(height: 10),

            // Button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                // like button
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),

                // next button
                ElevatedButton(
                  onPressed: () {
                    //print('button pressed!');
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),

              ],
            ),

          ], // children
        ),
      ),
    );
  }
} // end myhomepage

// --------------------------

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // change text apperance
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      //color: theme.colorScheme.primary,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(20),
        //child: Text(pair.asLowerCase),
        child: Text(
            pair.asLowerCase,
            style: style,
            semanticsLabel: "${pair.first} ${pair.second}",
        ), // added text change
      ),
    );
  }

} // end

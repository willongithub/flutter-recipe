import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

void main() => runApp(const Fooderlich());

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.dark();
    // TODO: Apply Home widget
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fooderlich', style: theme.textTheme.headline6),
        ),
        body: Center(
          child: Text('Let\'s get cooking 🧑‍🍳',
              style: theme.textTheme.headline1),
        ),
      ),
    );
  }
}


//// Section 1 ////
// import 'package:flutter/material.dart';

// import 'recipe.dart';
// import 'recipe_detail.dart';

// void main() {
//   runApp(const RecipeApp());
// }

// class RecipeApp extends StatelessWidget {
//   const RecipeApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = ThemeData();

//     return MaterialApp(
//       title: 'Recipe Calculator',
//       theme: theme.copyWith(
//         colorScheme: theme.colorScheme.copyWith(
//           primary: Colors.grey,
//           secondary: Colors.black,
//         ),
//       ),
//       home: const MyHomePage(title: 'Recipe Calculator'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: Recipe.samples.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return RecipeDetail(recipe: Recipe.samples[index]);
//                     },
//                   ),
//                 );
//               },
//               child: buildRecipeCard(Recipe.samples[index]),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildRecipeCard(Recipe recipe) {
//     return Card(
//       elevation: 2.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Image(image: AssetImage(recipe.imageUrl)),
//             const SizedBox(
//               height: 14.0,
//             ),
//             Text(
//               recipe.label,
//               style: const TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.w700,
//                 fontFamily: 'Palatino',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

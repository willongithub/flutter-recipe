import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

import 'fooderlich_theme.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';
import 'navigation/app_route_parser.dart';
import 'data/memory_repository.dart';
import 'api/mock_service.dart';

void main() {
  _setupLogging();

  // Provider.debugCheckInvalidValueType = null;

  runApp(
    const Fooderlich(),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  final _memoryRepository = MemoryRepository();

  final _mockService = MockService()..create();

  late AppRouter _appRouter;

  final routeParser = AppRouteParser();

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
      memoryRepository: _memoryRepository,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _groceryManager),
        ChangeNotifierProvider(create: (_) => _profileManager),
        ChangeNotifierProvider(create: (_) => _appStateManager),
        ChangeNotifierProvider(create: (_) => _memoryRepository),
        Provider(create: (_) => _mockService),
        // Provider<GroceryManager>(create: (_) => _groceryManager),
        // Provider<ProfileManager>(create: (_) => _profileManager),
        // Provider<AppStateManager>(create: (_) => _appStateManager),
        // Provider<MemoryRepository>(create: (_) => _memoryRepository),
      ],
      // providers: [
      //   // 2
      //   ChangeNotifierProvider<MemoryRepository>(
      //     lazy: false,
      //     create: (_) => MemoryRepository(),
      //   ),
      //   // 3
      //   Provider(
      //     // 4
      //     create: (_) => MockService()..create(),
      //     lazy: false,
      //   ),
      // ],
      child: Consumer<ProfileManager>(
        builder: (context, manager, child) {
          ThemeData theme;
          if (manager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'Fooderlich',
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
              routeInformationParser: routeParser,
            ),
          );
        },
      ),
    );
  }
}



//// Section 2 ////
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:recipes/home.dart';
// import 'package:recipes/models/tab_manager.dart';
// import 'package:recipes/models/grocery_manager.dart';
// import 'fooderlich_theme.dart';

// void main() => runApp(const Fooderlich());

// class Fooderlich extends StatelessWidget {
//   const Fooderlich({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = FooderlichTheme.light();

//     return MaterialApp(
//       theme: theme,
//       title: 'Fooderlich',
//       home: MultiProvider(
//         providers: [
//           // 2
//           ChangeNotifierProvider(create: (context) => TabManager()),
//           ChangeNotifierProvider(create: (context) => GroceryManager()),
//         ],
//         child: const Home(),
//       ),
//     );
//   }
// }



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

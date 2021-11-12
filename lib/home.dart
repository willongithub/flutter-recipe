import 'package:flutter/material.dart';
import 'package:recipes/screens/explore_screen.dart';
import 'package:recipes/screens/recipes_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    Container(color: Colors.blue),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To Buy',
          ),
        ],
      ),
    );
  }
}



// Chapter 4
// import 'package:flutter/material.dart';

// import 'card1.dart';
// import 'card2.dart';
// import 'card3.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _selectedIndex = 0;

//   static List<Widget> pages = <Widget>[
//     const Card1(),
//     const Card2(),
//     const Card3(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Fooderlich',
//           style: Theme.of(context).textTheme.headline6,
//         ),
//       ),
//       // TODO: Show selected tab
//       body: pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_giftcard),
//             label: 'Card1',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_giftcard),
//             label: 'Card2',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_giftcard),
//             label: 'Card3',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recipes/screens/screens.dart';
import 'package:recipes/models/models.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FooderlichPages.home,
      key: ValueKey(FooderlichPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    const ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, manager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Fooderlich',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              profileButton(),
            ],
          ),
          body: IndexedStack(index: manager.getSelectedTab, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            // currentIndex: manager.selectedTab,
            currentIndex: widget.currentTab,
            onTap: (index) {
              // manager.goToTab(index);
              Provider.of<AppStateManager>(context, listen: false)
                  .goToTab(index);
            },
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
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
          Provider.of<ProfileManager>(context, listen: false)
              .tapOnProfile(true);
        },
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

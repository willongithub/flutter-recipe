import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
// import 'grocery_edit_screen.dart';
import '../components/grocery_tile.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 6
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 1
          Provider.of<GroceryManager>(context, listen: false).createNewItem();
          // final manager = Provider.of<GroceryManager>(context, listen: false);
          // 2
          // Navigator.push(
          //   context,
          //   // 3
          //   MaterialPageRoute(
          //     // 4
          //     builder: (context) => GroceryEditScreen(
          //       // 5
          //       onCreate: (item) {
          //         // 6
          //         manager.addItem(item);
          //         // 7
          //         Navigator.pop(context);
          //       },
          //       // 8
          //       onUpdate: (_) {},
          //     ),
          //   ),
          // );
        },
      ),
      // 7
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    // 1
    return Consumer<GroceryManager>(
      // 2
      builder: (context, manager, child) {
        // 3
        if (manager.groceryItems.isNotEmpty) {
          return ListGroceryScreen(manager: manager);
        } else {
          // 4
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      // 2
      child: Center(
        // 3
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              // 2
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'),
              ),
            ),
            Text(
              'No Groceries',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Shopping for ingredients?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              textColor: Colors.white,
              child: const Text('Browse Recipes'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.green,
              onPressed: () {
                Provider.of<AppStateManager>(context, listen: false).goToTab(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListGroceryScreen extends StatelessWidget {
  final GroceryManager manager;

  const ListGroceryScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    final groceryItems = manager.groceryItems;
// 2
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // 3
      child: ListView.separated(
        // 4
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          // 5
          return Dismissible(
            // 6
            key: Key(item.id),
            // 7
            direction: DismissDirection.endToStart,
            // 8
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            // 9
            onDismissed: (direction) {
              // 10
              manager.deleteItem(index);
              // 11
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} dismissed'),
                ),
              );
            },
            child: InkWell(
              child: GroceryTile(
                key: Key(item.id),
                item: item,
                // 6
                onComplete: (change) {
                  // 7
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                },
              ),
              onTap: () {
                manager.groceryItemTapped(index);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GroceryEditScreen(
                //       originalItem: item,
                //       // 3
                //       onUpdate: (item) {
                //         // 4
                //         manager.updateItem(item, index);
                //         // 5
                //         Navigator.pop(context);
                //       },
                //       // 6
                //       onCreate: (_) {},
                //     ),
                //   ),
                // );
              },
            ),
          );
        },
        // 8
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}

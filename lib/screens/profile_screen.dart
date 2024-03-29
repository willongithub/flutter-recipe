import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/circle_image.dart';
import '../models/models.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  static MaterialPage page(User user) {
    return MaterialPage(
      name: FooderlichPages.profilePath,
      key: ValueKey(FooderlichPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        buildMockServiceRow(),
        buildDarkModeRow(),
        ListTile(
          title: const Text('About'),
          onTap: () async {
            if (kIsWeb) {
              await launch('https://www.raywenderlich.com/');
            } else {
              Provider.of<ProfileManager>(context, listen: false)
                  .tapOnAbout(true);
            }
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
            Provider.of<AppStateManager>(context, listen: false).logout();
          },
        )
      ],
    );
  }

  Widget buildMockServiceRow() {
    return SwitchListTile(
      title: const Text('Mock Query'),
      value: widget.user.mockQuery,
      onChanged: (value) {
        Provider.of<ProfileManager>(context, listen: false).mockQuery = value;
      },
    );
  }

  Widget buildDarkModeRow() {
    // return Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       const Text('Dark Mode'),
    //       Switch(
    //         value: widget.user.darkMode,
    //         onChanged: (value) {
    //           Provider.of<ProfileManager>(context, listen: false).darkMode =
    //               value;
    //         },
    //       )
    //     ],
    //   ),
    // );
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: widget.user.darkMode,
      onChanged: (value) {
        Provider.of<ProfileManager>(context, listen: false).darkMode = value;
      },
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user.firstName,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          widget.user.role,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${widget.user.points} points',
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}

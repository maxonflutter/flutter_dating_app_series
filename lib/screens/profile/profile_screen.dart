import 'package:flutter/material.dart';
import 'package:flutter_dating_app/models/models.dart';
import 'package:flutter_dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:flutter_dating_app/widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.users[0];
    return Scaffold(
      appBar: CustomAppBar(
        title: 'PROFILE',
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user.imageUrls[0]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ]),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).primaryColor.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Text(
                      user.name,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithIcon(title: 'Biography', icon: Icons.edit),
                Text(
                  user.bio,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(height: 1.5),
                ),
                SizedBox(height: 10),
                TitleWithIcon(title: 'Pictures', icon: Icons.edit),
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Container(
                          height: 125,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                user.imageUrls[0],
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(2.0),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TitleWithIcon(title: 'Location', icon: Icons.edit),
                Text(
                  'Singapore, 1 Shenton Way',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(height: 1.5),
                ),
                TitleWithIcon(title: 'Interests', icon: Icons.edit),
                Row(
                  children: [
                    CustomTextContainer(text: 'MUSIC'),
                    CustomTextContainer(text: 'ECONOMICS'),
                    CustomTextContainer(text: 'FOOTBALL'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        IconButton(icon: Icon(icon), onPressed: () {})
      ],
    );
  }
}

class CustomImageContainer extends StatelessWidget {
  const CustomImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            top: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            left: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            right: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

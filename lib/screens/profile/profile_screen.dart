import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/repositories/location/location_repository.dart';
import 'package:flutter_dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/location_model.dart';
import '/blocs/blocs.dart';
import '/repositories/repositories.dart';
import '/screens/screens.dart';
import '/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        print(BlocProvider.of<AuthBloc>(context).state);

        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.unauthenticated
            ? LoginScreen()
            : BlocProvider<ProfileBloc>(
                create: (context) => ProfileBloc(
                  authBloc: BlocProvider.of<AuthBloc>(context),
                  databaseRepository: context.read<DatabaseRepository>(),
                  locationRepository: context.read<LocationRepository>(),
                )..add(
                    LoadProfile(
                        userId: context.read<AuthBloc>().state.authUser!.uid),
                  ),
                child: ProfileScreen(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'PROFILE'),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  SizedBox(height: 10),
                  UserImage.medium(
                    url: state.user.imageUrls[0],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.1),
                            Theme.of(context).primaryColor.withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Text(
                            state.user.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          text: 'View',
                          beginColor: state.isEditingOn
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          endColor: state.isEditingOn
                              ? Colors.white
                              : Theme.of(context).accentColor,
                          textColor: state.isEditingOn
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                                  SaveProfile(user: state.user),
                                );
                          },
                          width: MediaQuery.of(context).size.width * 0.45,
                        ),
                        SizedBox(width: 10),
                        CustomElevatedButton(
                          text: 'Edit',
                          beginColor: state.isEditingOn
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          endColor: state.isEditingOn
                              ? Theme.of(context).accentColor
                              : Colors.white,
                          textColor: state.isEditingOn
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                                  EditProfile(isEditingOn: true),
                                );
                          },
                          width: MediaQuery.of(context).size.width * 0.45,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TextField(
                          title: 'Biography',
                          value: state.user.bio,
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                    user: state.user.copyWith(bio: value),
                                  ),
                                );
                          },
                        ),
                        _TextField(
                          title: 'Age',
                          value: '${state.user.age}',
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                    user: state.user.copyWith(
                                      age: int.parse(value!),
                                    ),
                                  ),
                                );
                          },
                        ),
                        _TextField(
                          title: 'Job Title',
                          value: state.user.jobTitle,
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                    user: state.user.copyWith(jobTitle: value),
                                  ),
                                );
                          },
                        ),
                        _Pictures(),
                        _Interests(),
                        _Location(
                          title: 'Location',
                          value: state.user.location!.name,
                        ),
                        _SignOut(),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Text('Something went wrong.');
            }
          },
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
            state.isEditingOn
                ? CustomTextField(
                    initialValue: value,
                    onChanged: onChanged,
                  )
                : Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.5),
                  ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _Pictures extends StatelessWidget {
  const _Pictures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pictures',
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: state.user.imageUrls.length > 0 ? 125 : 0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.user.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: UserImage.small(
                      width: 100,
                      url: state.user.imageUrls[index],
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Location extends StatelessWidget {
  const _Location({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
            state.isEditingOn
                ? CustomTextField(
                    initialValue: value,
                    onChanged: (value) {
                      Location location =
                          state.user.location!.copyWith(name: value);
                      context
                          .read<ProfileBloc>()
                          .add(UpdateUserLocation(location: location));
                    },
                    onFocusChanged: (hasFocus) {
                      if (hasFocus) {
                        return;
                      } else {
                        context.read<ProfileBloc>().add(
                              UpdateUserLocation(
                                isUpdateComplete: true,
                                location: state.user.location,
                              ),
                            );
                      }
                    },
                  )
                : Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.5),
                  ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  context.read<ProfileBloc>().add(
                        UpdateUserLocation(controller: controller),
                      );
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    state.user.location!.lat.toDouble(),
                    state.user.location!.lon.toDouble(),
                  ),
                  zoom: 10,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _Interests extends StatelessWidget {
  const _Interests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interest',
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              children: [
                CustomTextContainer(text: 'MUSIC'),
                CustomTextContainer(text: 'ECONOMICS'),
                CustomTextContainer(text: 'FOOTBALL'),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _SignOut extends StatelessWidget {
  const _SignOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                RepositoryProvider.of<AuthRepository>(context).signOut();
              },
              child: Center(
                child: Text(
                  'Sign Out',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

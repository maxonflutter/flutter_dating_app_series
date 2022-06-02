import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/repositories/location/location_repository.dart';

import '/blocs/blocs.dart';
import '/repositories/repositories.dart';
import '/screens/screens.dart';
import '/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

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
                child: SettingsScreen(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'SETTINGS'),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withAlpha(50),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).accentColor,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Set Up your Preferences',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _GenderPreference(),
                    _AgeRangePreference(),
                    _DistancePreference(),
                  ],
                ),
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

class _DistancePreference extends StatelessWidget {
  const _DistancePreference({
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
              'Maximum Distance',
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: state.user.distancePreference!.toDouble(),
                    min: 0,
                    max: 100,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                distancePreference: value.toInt(),
                              ),
                            ),
                          );
                    },
                    onChangeEnd: (double newValue) {
                      print('Ended change on $newValue');
                      context.read<ProfileBloc>().add(
                            SaveProfile(
                              user: state.user.copyWith(
                                distancePreference: newValue.toInt(),
                              ),
                            ),
                          );
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${state.user.distancePreference!} km',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _AgeRangePreference extends StatelessWidget {
  const _AgeRangePreference({
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
              'Age Range',
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              children: [
                Expanded(
                  child: RangeSlider(
                    values: RangeValues(
                      state.user.ageRangePreference![0].toDouble(),
                      state.user.ageRangePreference![1].toDouble(),
                    ),
                    min: 18,
                    max: 100,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).primaryColor,
                    onChanged: (rangeValues) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                ageRangePreference: [
                                  rangeValues.start.toInt(),
                                  rangeValues.end.toInt(),
                                ],
                              ),
                            ),
                          );
                    },
                    onChangeEnd: (RangeValues newRangeValues) {
                      print('Ended change on $newRangeValues');
                      context.read<ProfileBloc>().add(
                            SaveProfile(
                              user: state.user.copyWith(
                                ageRangePreference: [
                                  newRangeValues.start.toInt(),
                                  newRangeValues.end.toInt(),
                                ],
                              ),
                            ),
                          );
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${state.user.ageRangePreference![0]} - ${state.user.ageRangePreference![1]}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _GenderPreference extends StatelessWidget {
  const _GenderPreference({
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
              'Show me: ',
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              children: [
                Checkbox(
                  value: state.user.genderPreference!.contains('Man'),
                  onChanged: (value) {
                    if (state.user.genderPreference!.contains('Man')) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..remove('Man'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    } else {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..add('Man'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    }
                  },
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  'Man',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: state.user.genderPreference!.contains('Woman'),
                  onChanged: (value) {
                    if (state.user.genderPreference!.contains('Woman')) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..remove('Woman'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    } else {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..add('Woman'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    }
                  },
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  'Woman',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

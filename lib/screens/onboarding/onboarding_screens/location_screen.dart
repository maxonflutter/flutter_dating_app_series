import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/screens/onboarding/widgets/widgets.dart';
import '/models/models.dart';
import '/blocs/blocs.dart';

class LocationTab extends StatelessWidget {
  final TabController tabController;

  const LocationTab({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextHeader(text: 'Where Are You?'),
                    CustomTextField(
                      hint: 'ENTER YOUR LOCATION',
                      onChanged: (value) {
                        Location location =
                            state.user.location!.copyWith(name: value);
                        context
                            .read<OnboardingBloc>()
                            .add(SetUserLocation(location: location));
                      },
                      onFocusChanged: (hasFocus) {
                        if (hasFocus) {
                          return;
                        } else {
                          context.read<OnboardingBloc>().add(
                                SetUserLocation(
                                  isUpdateComplete: true,
                                  location: state.user.location,
                                ),
                              );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      context.read<OnboardingBloc>().add(
                            SetUserLocation(controller: controller),
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
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 6,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).backgroundColor,
                    ),
                    SizedBox(height: 10),
                    CustomButton(tabController: tabController, text: 'DONE'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}

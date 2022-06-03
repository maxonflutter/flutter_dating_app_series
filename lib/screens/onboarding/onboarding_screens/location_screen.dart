import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/blocs/blocs.dart';
import '/models/models.dart';
import '/screens/onboarding/widgets/widgets.dart';
import '../../screens.dart';

class LocationTab extends StatelessWidget {
  const LocationTab({
    Key? key,
    required this.state,
  }) : super(key: key);

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
      currentStep: 6,
      children: [
        CustomTextHeader(text: 'Where Are You?'),
        CustomTextField(
          hint: 'ENTER YOUR LOCATION',
          onChanged: (value) {
            Location location = state.user.location!.copyWith(name: value);
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
      ],
      onPressed: () {
        context
            .read<OnboardingBloc>()
            .add(ContinueOnboarding(user: state.user));
      },
    );
  }
}

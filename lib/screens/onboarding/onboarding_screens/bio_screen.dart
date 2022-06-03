import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/blocs.dart';
import '/screens/onboarding/widgets/widgets.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';

class BioTab extends StatelessWidget {
  const BioTab({
    Key? key,
    required this.state,
  }) : super(key: key);

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
      currentStep: 5,
      children: [
        CustomTextHeader(text: 'Describe Yourself'),
        CustomTextField(
          hint: 'ENTER YOUR BIO',
          onChanged: (value) {
            context.read<OnboardingBloc>().add(
                  UpdateUser(
                    user: state.user.copyWith(bio: value),
                  ),
                );
          },
        ),
        SizedBox(height: 50),
        CustomTextHeader(text: 'What do you do?'),
        CustomTextField(
          hint: 'ENTER YOUR JOB TITLE',
          onChanged: (value) {
            context.read<OnboardingBloc>().add(
                  UpdateUser(
                    user: state.user.copyWith(jobTitle: value),
                  ),
                );
          },
        ),
        SizedBox(height: 50),
        CustomTextHeader(text: 'What Do You Like?'),
        Row(
          children: [
            CustomTextContainer(text: 'MUSIC'),
            CustomTextContainer(text: 'ECONOMICS'),
            CustomTextContainer(text: 'POLITICS'),
            CustomTextContainer(text: 'ART'),
          ],
        ),
        Row(
          children: [
            CustomTextContainer(text: 'NATURE'),
            CustomTextContainer(text: 'HIKING'),
            CustomTextContainer(text: 'FOOTBALL'),
            CustomTextContainer(text: 'MOVIES'),
          ],
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

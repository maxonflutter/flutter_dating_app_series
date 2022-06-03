import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/blocs.dart';
import '/cubits/cubits.dart';
import '/models/models.dart';
import '/screens/onboarding/widgets/widgets.dart';
import '../onboarding_screen.dart';

class EmailTab extends StatelessWidget {
  const EmailTab({
    Key? key,
    required this.state,
  }) : super(key: key);

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
      currentStep: 2,
      children: [
        CustomTextHeader(text: 'What\'s Your Email?'),
        CustomTextField(
          hint: 'ENTER YOUR EMAIL',
          onChanged: (value) {
            context.read<SignupCubit>().emailChanged(value);
          },
        ),
        SizedBox(height: 50),
        CustomTextHeader(text: 'Choose a Password'),
        CustomTextField(
          hint: 'ENTER YOUR PASSWORD',
          onChanged: (value) {
            context.read<SignupCubit>().passwordChanged(value);
          },
        ),
      ],
      onPressed: () async {
        await context.read<SignupCubit>().signUpWithCredentials();
        context.read<OnboardingBloc>().add(
              ContinueOnboarding(
                isSignup: true,
                user: User.empty.copyWith(
                  id: context.read<SignupCubit>().state.user!.uid,
                ),
              ),
            );
      },
    );
  }
}

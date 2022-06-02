import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../blocs/blocs.dart';
import '../../../models/models.dart';
import '/cubits/cubits.dart';
import '/screens/onboarding/widgets/widgets.dart';

class EmailTab extends StatelessWidget {
  const EmailTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(text: 'What\'s Your Email Address?'),
              CustomTextField(
                hint: 'ENTER YOUR EMAIL',
                onChanged: (value) {
                  context.read<SignupCubit>().emailChanged(value);
                },
              ),
              SizedBox(height: 100),
              CustomTextHeader(text: 'Choose a Password'),
              CustomTextField(
                hint: 'ENTER YOUR PASSWORD',
                onChanged: (value) {
                  context.read<SignupCubit>().passwordChanged(value);
                },
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).backgroundColor,
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'NEXT STEP',
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

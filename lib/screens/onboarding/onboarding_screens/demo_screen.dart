import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '/blocs/blocs.dart';
import '/screens/onboarding/widgets/widgets.dart';

class Demo extends StatelessWidget {
  final TabController tabController;

  const Demo({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextHeader(text: 'What\'s Your Gender?'),
                  SizedBox(height: 20),
                  CustomCheckbox(
                    text: 'MALE',
                    onChanged: (bool? newValue) {
                      context.read<OnboardingBloc>().add(
                            UpdateUser(
                              user: (state as OnboardingLoaded)
                                  .user
                                  .copyWith(gender: 'Male'),
                            ),
                          );
                    },
                  ),
                  CustomCheckbox(
                    text: 'FEMALE',
                    onChanged: (bool? newValue) {
                      context.read<OnboardingBloc>().add(
                            UpdateUser(
                              user: (state as OnboardingLoaded)
                                  .user
                                  .copyWith(gender: 'Female'),
                            ),
                          );
                    },
                  ),
                  SizedBox(height: 100),
                  CustomTextHeader(text: 'What\'s Your Age?'),
                  CustomTextField(
                    hint: 'ENTER YOUR AGE',
                    onChanged: (value) {
                      context.read<OnboardingBloc>().add(
                            UpdateUser(
                              user: (state as OnboardingLoaded)
                                  .user
                                  .copyWith(age: int.parse(value)),
                            ),
                          );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 3,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).backgroundColor,
                  ),
                  SizedBox(height: 10),
                  CustomButton(tabController: tabController, text: 'NEXT STEP'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

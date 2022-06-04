import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
        BlocBuilder<SignupCubit, SignupState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            return CustomTextField(
              hint: 'ENTER YOUR EMAIL',
              errorText: state.email.invalid ? 'The email is invalid.' : null,
              onChanged: (value) {
                context.read<SignupCubit>().emailChanged(value);
              },
            );
          },
        ),
        SizedBox(height: 50),
        CustomTextHeader(text: 'Choose a Password'),
        BlocBuilder<SignupCubit, SignupState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            return CustomTextField(
              hint: 'ENTER YOUR PASSWORD',
              errorText: state.password.invalid
                  ? 'The password must contain at least 8 characters.'
                  : null,
              onChanged: (value) {
                context.read<SignupCubit>().passwordChanged(value);
              },
            );
          },
        ),
      ],
      onPressed: () async {
        if (BlocProvider.of<SignupCubit>(context).state.status ==
            FormzStatus.valid) {
          await context.read<SignupCubit>().signUpWithCredentials();
          context.read<OnboardingBloc>().add(
                ContinueOnboarding(
                  isSignup: true,
                  user: User.empty.copyWith(
                    id: context.read<SignupCubit>().state.user!.uid,
                  ),
                ),
              );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Check your email and password'),
            ),
          );
        }
      },
    );
  }
}

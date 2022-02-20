import 'package:flutter/material.dart';
import 'package:flutter_dating_app/blocs/blocs.dart';
import 'package:flutter_dating_app/cubits/signup/signup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/models/models.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final void function;

  CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (tabController.index == 5) {
            Navigator.pushNamed(context, '/');
          } else {
            tabController.animateTo(tabController.index + 1);
          }

          if (tabController.index == 2) {
            await context.read<SignupCubit>().signUpWithCredentials();

            User user = User(
              id: context.read<SignupCubit>().state.user!.uid,
              name: '',
              age: 0,
              gender: '',
              imageUrls: [],
              jobTitle: '',
              interests: [],
              bio: '',
              location: '',
            );
            context.read<OnboardingBloc>().add(
                  StartOnboarding(
                    user: user,
                  ),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

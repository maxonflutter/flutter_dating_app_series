import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/blocs/blocs.dart';
import '/screens/onboarding/widgets/widgets.dart';

class StartTab extends StatelessWidget {
  const StartTab({
    Key? key,
    required this.state,
  }) : super(key: key);

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              height: 200,
              width: 200,
              child: SvgPicture.asset(
                'assets/couple.svg',
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Welcome to Arrow',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 20),
            Text(
              'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(height: 1.8),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        CustomButton(
          text: 'START',
          onPressed: () {
            context
                .read<OnboardingBloc>()
                .add(ContinueOnboarding(user: state.user));
          },
        )
      ],
    );
  }
}

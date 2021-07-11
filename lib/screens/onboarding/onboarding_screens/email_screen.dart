import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(text: 'What\'s Your Email Address?'),
              CustomTextField(
                hint: 'ENTER YOUR EMAIL',
                controller: emailController,
              ),
              SizedBox(height: 100),
              CustomTextHeader(text: 'Choose a Password'),
              CustomTextField(
                hint: 'ENTER YOUR PASSWORD',
                controller: passwordController,
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
                tabController: tabController,
                text: 'NEXT STEP',
                emailController: emailController,
                passwordController: passwordController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

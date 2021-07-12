import 'package:flutter/material.dart';
import 'package:flutter_dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Demo extends StatelessWidget {
  final TabController tabController;

  const Demo({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
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
              CustomCheckbox(text: 'MALE'),
              CustomCheckbox(text: 'FEMALE'),
              SizedBox(height: 100),
              CustomTextHeader(text: 'What\'s Your Age?'),
              CustomTextField(
                hint: 'ENTER YOUR AGE',
                // controller: controller,
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
  }
}

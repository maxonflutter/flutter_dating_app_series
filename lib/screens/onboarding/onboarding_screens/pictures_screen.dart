import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '/blocs/blocs.dart';
import '/screens/onboarding/widgets/widgets.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;

  const Pictures({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        var images = (state as OnboardingLoaded).user.imageUrls;
        var imageCount = images.length;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextHeader(text: 'Add 2 or More Pictures'),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                          (imageCount > 0)
                              ? CustomImageContainer(imageUrl: images[0])
                              : CustomImageContainer(),
                          (imageCount > 1)
                              ? CustomImageContainer(imageUrl: images[1])
                              : CustomImageContainer(),
                          (imageCount > 2)
                              ? CustomImageContainer(imageUrl: images[2])
                              : CustomImageContainer(),
                        ],
                      ),
                      Row(
                        children: [
                          (imageCount > 3)
                              ? CustomImageContainer(imageUrl: images[3])
                              : CustomImageContainer(),
                          (imageCount > 4)
                              ? CustomImageContainer(imageUrl: images[4])
                              : CustomImageContainer(),
                          (imageCount > 5)
                              ? CustomImageContainer(imageUrl: images[5])
                              : CustomImageContainer(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 4,
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

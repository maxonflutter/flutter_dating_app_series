import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/blocs/images/images_bloc.dart';
import 'package:flutter_dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;

  const Pictures({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

              BlocBuilder<ImagesBloc, ImagesState>(
                builder: (context, state) {
                  if (state is ImagesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ImagesLoaded) {
                    var imageCount = state.imageUrls.length;
                    return Column(
                      children: [
                        Row(
                          children: [
                            (imageCount > 0)
                                ? CustomImageContainer(
                                    imageUrl: state.imageUrls[0])
                                : CustomImageContainer(),
                            (imageCount > 1)
                                ? CustomImageContainer(
                                    imageUrl: state.imageUrls[1])
                                : CustomImageContainer(),
                            (imageCount > 2)
                                ? CustomImageContainer(
                                    imageUrl: state.imageUrls[2])
                                : CustomImageContainer(),
                          ],
                        ),
                        Row(
                          children: [
                            (imageCount > 3)
                                ? CustomImageContainer(
                                    imageUrl: state.imageUrls[3])
                                : CustomImageContainer(),
                            (imageCount > 4)
                                ? CustomImageContainer(
                                    imageUrl: state.imageUrls[4])
                                : CustomImageContainer(),
                            (imageCount > 5)
                                ? CustomImageContainer(
                                    imageUrl: state.imageUrls[5])
                                : CustomImageContainer(),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Text('Something went wrong.');
                  }
                },
              ),

              // StreamBuilder(
              //     stream: DatabaseRepository().getUser(),
              //     builder:
              //         (BuildContext context, AsyncSnapshot<User> snapshot) {
              //       if (snapshot.hasError) {
              //         return Text('Something went wrong');
              //       }
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Text("Loading");
              //       }
              //       return Container(
              //         child: Text(snapshot.data!.imageUrls.toString()),
              //       );
              //     })
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
  }
}

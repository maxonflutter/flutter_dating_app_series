import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/blocs/blocs.dart';
import '/screens/onboarding/widgets/widgets.dart';
import '/widgets/widgets.dart';
import '../../screens.dart';

class PicturesTab extends StatelessWidget {
  const PicturesTab({
    Key? key,
    required this.state,
  }) : super(key: key);

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    var images = state.user.imageUrls;
    var imageCount = images.length;

    return OnboardingScreenLayout(
      currentStep: 4,
      children: [
        CustomTextHeader(text: 'Add 2 or More Pictures'),
        SizedBox(height: 20),
        SizedBox(
          height: 350,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.66,
            ),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return (imageCount > index)
                  ? UserImage.medium(
                      url: images[index],
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                        right: 10.0,
                      ),
                    )
                  : AddUserImage(
                      onPressed: () async {
                        ImagePicker _picker = ImagePicker();
                        print('Picker: $_picker');

                        final XFile? _image = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 50);

                        print('Image: $_image');
                        if (_image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No image was selected.'),
                            ),
                          );
                        }

                        if (_image != null) {
                          print('Uploading ...');
                          BlocProvider.of<OnboardingBloc>(context).add(
                            UpdateUserImages(image: _image),
                          );
                        }
                      },
                    );
            },
          ),
        ),
      ],
      onPressed: () {
        context
            .read<OnboardingBloc>()
            .add(ContinueOnboarding(user: state.user));
      },
    );
  }
}

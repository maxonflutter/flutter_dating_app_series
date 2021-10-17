part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class LoadImages extends ImagesEvent {}

class UpdateImages extends ImagesEvent {
  final List<dynamic> imageUrls;

  UpdateImages(this.imageUrls);

  @override
  List<Object> get props => [imageUrls];
}
